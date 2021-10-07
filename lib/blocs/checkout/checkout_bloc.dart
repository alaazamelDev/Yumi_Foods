import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:online_market/blocs/cart/cart_bloc.dart';
import 'package:online_market/models/checkout_model.dart';
import 'package:online_market/models/models.dart';
import 'package:online_market/repositories/checkout/checkout_repository.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CheckoutRepository _repository;
  final CartBloc _cartBloc;
  StreamSubscription? _checkoutSubscription;
  StreamSubscription? _cartSubscription;

  CheckoutBloc({
    required CheckoutRepository checkoutRepository,
    required CartBloc cartBloc,
  })  : _repository = checkoutRepository,
        _cartBloc = cartBloc,
        super(
          cartBloc.state is CartLoaded
              ? CheckoutLoaded(
                  products: (cartBloc.state as CartLoaded).cart.products,
                  subtotal: (cartBloc.state as CartLoaded).cart.subtotalString,
                  total: (cartBloc.state as CartLoaded).cart.totalString,
                  deliveryFee:
                      (cartBloc.state as CartLoaded).cart.deliveryFeeString,
                )
              : CheckoutLoading(),
        ) {
    _cartSubscription = cartBloc.stream.listen((state) {
      if (state is CartLoaded) {
        //when new products added to the cart update the checkout state
        add(UpdateCheckout(cart: state.cart));
      }
    });
  }

  @override
  Stream<CheckoutState> mapEventToState(CheckoutEvent event) async* {
    if (event is UpdateCheckout) {
      yield* _mapUpdateCheckoutToState(event, state);
    }
    if (event is ConfirmCheckout) {
      yield* _mapConfirmCheckoutToState(event, state);
    }
    if (event is ResetCheckout) {
      yield* _mapResetCheckoutToState();
    }
  }

  Stream<CheckoutState> _mapResetCheckoutToState() async* {
    try {
      //clear the cart and make it empty
      if (_cartBloc.state is CartLoaded) {
        for (Product product in (_cartBloc.state as CartLoaded).cart.products) {
          _cartBloc.add(RemoveFromCart(product: product));
        }
      }
      //reload checkout screen with empty data
      yield CheckoutLoaded(
        fullname: '',
        email: '',
        city: '',
        country: '',
        address: '',
        zipCode: '',
        products: (_cartBloc.state as CartLoaded).cart.products,
        subtotal: (_cartBloc.state as CartLoaded).cart.subtotalString,
        deliveryFee: (_cartBloc.state as CartLoaded).cart.deliveryFeeString,
        total: (_cartBloc.state as CartLoaded).cart.totalString,
      );
      print('Has been reset');
    } catch (_) {
      print('Error occured while resetting the checkout!!!');
    }
  }

  Stream<CheckoutState> _mapUpdateCheckoutToState(
    UpdateCheckout event,
    CheckoutState state,
  ) async* {
    if (state is CheckoutLoaded) {
      yield CheckoutLoaded(
        fullname: event.fullname ?? state.fullname,
        email: event.email ?? state.email,
        address: event.address ?? state.address,
        city: event.city ?? state.city,
        country: event.country ?? state.country,
        zipCode: event.zipCode ?? state.zipCode,
        products: event.cart?.products ?? state.products,
        deliveryFee: event.cart?.deliveryFeeString ?? state.deliveryFee,
        subtotal: event.cart?.subtotalString ?? state.subtotal,
        total: event.cart?.totalString ?? state.total,
      );
    }
  }

  Stream<CheckoutState> _mapConfirmCheckoutToState(
    ConfirmCheckout event,
    CheckoutState state,
  ) async* {
    _checkoutSubscription?.cancel();
    try {
      yield CheckoutLoading();
      await _repository.addCheckout(event.checkout!);
      print('Done');
      yield CheckoutCompleted();
    } catch (_) {
      print('Error occured while confirming the order!!!');
    }
  }
}
