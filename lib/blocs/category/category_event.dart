part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class LoadCategories extends CategoryEvent {}

class UpdateCategories extends CategoryEvent {
  //new version of categories list
  final List<Category> categories;

  const UpdateCategories({required this.categories});
}
