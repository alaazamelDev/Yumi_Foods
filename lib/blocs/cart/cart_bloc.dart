import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:online_market/models/models.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is InitializeCart) {
      yield* _mapInitializeCartToState();
    } else if (event is AddToCart) {
      yield* _mapAddToCartToState(event, state);
    } else if (event is RemoveFromCart) {
      yield* _mapRemoveFromCartToState(event, state);
    }
  }

  Stream<CartState> _mapInitializeCartToState() async* {
    yield CartLoading();
    try {
      await Future.delayed(const Duration(seconds: 2));
      yield const CartLoaded();
    } catch (_) {
      yield CartError();
    }
  }

  Stream<CartState> _mapAddToCartToState(
      AddToCart event, CartState state) async* {
    if (state is CartLoaded) {
      try {
        yield CartLoaded(
          cart: Cart(
            products: List.from(state.cart.products)..add(event.product),
          ),
        );
      } catch (_) {}
    }
  }

  Stream<CartState> _mapRemoveFromCartToState(
      RemoveFromCart event, CartState state) async* {
    if (state is CartLoaded) {
      try {
        yield CartLoaded(
          cart: Cart(
            products: List.from(state.cart.products)..remove(event.product),
          ),
        );
      } catch (_) {}
    }
  }
}
