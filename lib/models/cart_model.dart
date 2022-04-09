import 'package:equatable/equatable.dart';
import 'package:yumi_food/models/models.dart';

class Cart extends Equatable {
  final List<Product> products;
  const Cart({this.products = const <Product>[]});

  @override
  List<Object?> get props => [products];

  Map productQuantity(List<Product> products) {
    var quantity = {};

    for (var product in products) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      } else {
        quantity[product] += 1;
      }
    }
    return quantity;
  }

  double get _subtotal =>
      products.fold(0, (total, current) => total + current.price);

  double _deliveryFee(subtotal) {
    if (subtotal == 0.0) {
      return 0.0;
    }
    if (subtotal >= 30) {
      return 0.0;
    }
    return 10.0;
  }

  double _total(double subtotal, deliveryFee) {
    return subtotal + deliveryFee(subtotal);
  }

  String _freeDelivery(double subtotal) {
    if (subtotal >= 30.0) {
      return 'You have free Delivery';
    }
    double needed = 30 - subtotal;
    return 'Add \$${needed.toStringAsFixed(2)} for FREE Delivery';
  }

  String get subtotalString => _subtotal.toStringAsFixed(2);

  String get totalString => _total(_subtotal, _deliveryFee).toStringAsFixed(2);

  String get deliveryFeeString => _deliveryFee(_subtotal).toStringAsFixed(2);

  String get freeDeliveryString => _freeDelivery(_subtotal);
}
