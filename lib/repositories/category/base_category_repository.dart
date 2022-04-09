import 'package:yumi_food/models/models.dart';

abstract class BaseCategoryRepository {
  //abstract method to fetch categories from db
  Stream<List<Category>> getAllCategories();
}
