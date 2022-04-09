import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yumi_food/models/models.dart';
import 'package:yumi_food/repositories/product/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  StreamSubscription? _productSubscription;
  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductLoading());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is LoadProducts) {
      yield* _mapLoadProductsToState();
    }
    if (event is UpdateProducts) {
      yield* _mapUpdateProductsToState(event);
    }
  }

  Stream<ProductState> _mapLoadProductsToState() async* {
    _productSubscription?.cancel(); //cancel previous loading operatiions
    _productSubscription = _productRepository
        .getAllProducts()
        .listen((products) => add(UpdateProducts(products: products)));
  }

  Stream<ProductState> _mapUpdateProductsToState(UpdateProducts event) async* {
    yield ProductLoaded(
        products: event.products); //reutrn new version of updated data
  }
}
