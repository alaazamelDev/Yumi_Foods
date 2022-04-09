import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yumi_food/models/models.dart';
import 'package:yumi_food/repositories/category/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;
  StreamSubscription? _categorySubscription;
  CategoryBloc({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(CategoryLoading());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is LoadCategories) {
      yield* _mapLoadCategoriesToState();
    } else if (event is UpdateCategories) {
      yield* _mapUpdateCategoriesToState(event);
    }
  }

  Stream<CategoryState> _mapLoadCategoriesToState() async* {
    _categorySubscription?.cancel(); //cancel previous operations
    _categorySubscription = _categoryRepository
        .getAllCategories() //fetch list of new categories
        //and trigger updateCategories event to refresh the UI with new data
        .listen((categories) => add(UpdateCategories(categories: categories)));
  }

  Stream<CategoryState> _mapUpdateCategoriesToState(
      UpdateCategories event) async* {
    //return the loaded state with new version of data
    yield CategoryLoaded(categories: event.categories);
  }
}
