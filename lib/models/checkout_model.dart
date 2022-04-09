import 'package:equatable/equatable.dart';
import 'package:yumi_food/models/models.dart';

class Checkout extends Equatable {
  final String? fullname;
  final String? email;
  final String? address;
  final String? city;
  final String? country;
  final String? zipCode;
  final List<Product>? products;
  final String? subtotal;
  final String? deliveryFee;
  final String? total;

  const Checkout({
    required this.fullname,
    required this.email,
    required this.address,
    required this.city,
    required this.country,
    required this.zipCode,
    required this.products,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
  });

  @override
  List<Object?> get props => [
        fullname,
        email,
        address,
        city,
        country,
        zipCode,
        products,
        subtotal,
        deliveryFee,
        total,
      ];

  Map<String, Object> toDocument() {
    Map customerAddress = {};
    customerAddress['address'] = address;
    customerAddress['city'] = city;
    customerAddress['country'] = country;
    customerAddress['zip code'] = zipCode;

    return {
      'customerAddress': customerAddress,
      'customerEmail': email!,
      'customerName': fullname!,
      'deliveryFee': deliveryFee!,
      'products': products!
          .map((product) => product.name)
          .toList(), //get only products names
      'subtotal': subtotal!,
      'total': total!,
    };
  }
}

//  checkout = Checkout(
//           fullname,
//           address,
//           city,
//           country,
//           zipCode,
//           products,
//           subtotal,
//           deliveryFee,
//           total,
//         );
