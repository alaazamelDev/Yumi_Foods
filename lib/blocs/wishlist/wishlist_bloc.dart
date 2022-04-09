import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yumi_food/models/models.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading());

  @override
  Stream<WishlistState> mapEventToState(WishlistEvent event) async* {
    if (event is InitializeWishlist) {
      yield* _mapInitializeWishlistToState();
    } else if (event is AddProductToWishlist) {
      yield* _mapAddProductToWishlistToState(event, state);
    } else if (event is RemoveProductFromWishlist) {
      yield* _mapRemoveProductFromWishlistToState(event, state);
    }
  }

  Stream<WishlistState> _mapInitializeWishlistToState() async* {
    yield WishlistLoading();
    try {
      await Future.delayed(const Duration(seconds: 1));
    } catch (_) {
      yield const WishlistError(message: 'Error While Initialization');
    }
    yield const WishlistLoaded();
  }

  Stream<WishlistState> _mapAddProductToWishlistToState(
    AddProductToWishlist event,
    WishlistState state,
  ) async* {
    if (state is WishlistLoaded) {
      try {
        yield WishlistLoaded(
          wishlist: Wishlist(
            products: List.from(state.wishlist.products)..add(event.product),
          ),
        );
      } catch (_) {
        yield const WishlistError(message: 'Error While Insertion');
      }
    }
  }

  Stream<WishlistState> _mapRemoveProductFromWishlistToState(
    RemoveProductFromWishlist event,
    WishlistState state,
  ) async* {
    if (state is WishlistLoaded) {
      try {
        yield WishlistLoaded(
          wishlist: Wishlist(
            products: List.from(state.wishlist.products)..remove(event.product),
          ),
        );
      } catch (_) {
        yield const WishlistError(message: 'Error While Deletion');
      }
    }
  }
}
