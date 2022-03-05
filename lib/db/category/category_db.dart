import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/models/category/category_model.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategory();
  //insert function declaration in abstract class
  Future<void> insertCategory(CategoryModel value);
}

class CategoryDB implements CategoryDbFunctions {
  ValueNotifier<List<CategoryModel>> incomeCategoryListListner = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListner = ValueNotifier([]);
  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.add(value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategory() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  //function for refreshing UI

  Future<void> refreshUI() async {
    final _allCategories = await getCategory();
    incomeCategoryListListner.value.clear();
    expenseCategoryListListner.value.clear();
    await Future.forEach(_allCategories, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeCategoryListListner.value.add(category);
      } else {
        expenseCategoryListListner.value.add(category);
      }
    });
    incomeCategoryListListner.notifyListeners();
    expenseCategoryListListner.notifyListeners();
  }
}
