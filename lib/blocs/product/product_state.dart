part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products; //list of fetched data

  const ProductLoaded({this.products = const <Product>[]});

  @override
  List<Object> get props => [products];
}
