import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String imageUrl;
  final String name;

  const Category({required this.name, required this.imageUrl});

  static Category fromSnapshot(DocumentSnapshot snap) {
    Category category = Category(
      name: snap['name'],
      imageUrl: snap['imageUrl'],
    );
    return category;
  }

  @override
  List<Object?> get props => [name, imageUrl];
}

final List<Category> categoriesList = [];
