part of 'wishlist_bloc.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final Wishlist wishlist; //loaded item
  const WishlistLoaded({this.wishlist = const Wishlist()});

  @override
  List<Object> get props => [wishlist];
}

class WishlistError extends WishlistState {
  final String message; //message to describe the ocurred error
  const WishlistError({this.message = 'UnKnown Error'});

  @override
  List<Object> get props => [message];
}
