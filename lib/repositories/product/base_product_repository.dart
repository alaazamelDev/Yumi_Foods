import 'package:online_market/models/models.dart';

abstract class BaseProductRepository {
  //method used to fetch list of all availabe products
  Stream<List<Product>> getAllProducts();
}
