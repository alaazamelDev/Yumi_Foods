import 'package:online_market/models/models.dart';

abstract class BaseCategoryRepository {

  //abstract method to fetch categories from db
  Stream<List<Category>> getAllCategories();

}
