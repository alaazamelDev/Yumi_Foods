import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yumi_food/models/product_model.dart';
import 'package:yumi_food/repositories/product/base_product_repository.dart';

class ProductRepository extends BaseProductRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProductRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Product>> getAllProducts() {
    return _firebaseFirestore.collection('products').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doucment) => Product.fromSnapshot(doucment))
            .toList());
  }
}
