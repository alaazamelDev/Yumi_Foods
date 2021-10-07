import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name;
  final String imageUrl;
  final String category;
  final double price;
  final bool isRecommended;
  final bool isPopular;

  const Product({
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.price,
    required this.isRecommended,
    required this.isPopular,
  });

  static Product fromSnapshot(DocumentSnapshot snap) {

    Product product = Product(
      name: snap['name'],
      imageUrl: snap['imageUrl'],
      category: snap['category'],
      price: snap['price'].toDouble(),
      isRecommended: snap['isRecommended'],
      isPopular: snap['isPopular'],
    );
    return product;
  }

  @override
  List<Object?> get props => [
        name,
        imageUrl,
        category,
        price,
        isRecommended,
        isPopular,
      ];
}

final List<Product> productsList = [
  const Product(
    name: 'Soft Drink #1',
    imageUrl:
        'https://images.unsplash.com/photo-1623586070432-003c94b019b1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=387&q=80',
    category: 'Soft Drinks',
    price: 5.92,
    isRecommended: false,
    isPopular: true,
  ),
  const Product(
    name: 'Soft Drink #2',
    imageUrl:
        'https://images.unsplash.com/photo-1555949366-819808d99159?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    category: 'Soft Drinks',
    price: 1.64,
    isRecommended: true,
    isPopular: false,
  ),
  const Product(
    name: 'Soft Drink #3',
    imageUrl:
        'https://images.unsplash.com/photo-1596633605700-1efc9b49e277?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1470&q=80',
    category: 'Soft Drinks',
    price: 3.19,
    isRecommended: false,
    isPopular: true,
  ),
  const Product(
    name: 'Soft Drink #4',
    imageUrl:
        'https://images.unsplash.com/photo-1595981266686-0cf387d0a608?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    category: 'Soft Drinks',
    price: 4.99,
    isRecommended: true,
    isPopular: true,
  ),
  const Product(
    name: 'Smoothies #1',
    imageUrl:
        'https://images.unsplash.com/photo-1625409493103-51badc065733?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=387&q=80',
    category: 'Smoothies',
    price: 9.84,
    isRecommended: true,
    isPopular: false,
  ),
  const Product(
    name: 'Smoothies #2',
    imageUrl:
        'https://images.unsplash.com/photo-1622119745123-96bbf01909c0?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=397&q=80',
    category: 'Smoothies',
    price: 7.29,
    isRecommended: false,
    isPopular: false,
  ),
];
