import 'package:money_manager/models/category/category_model.dart';

abstract class CategoryDbFunctions {
  List<CategoryModel> getCategory();
  //insert function declaration in abstract class
  Future<void> insertCategory(CategoryModel value);
}

class CategoryDB implements CategoryDbFunctions{


  @override
  Future<void> insertCategory(CategoryModel value) async{
   
  }

  @override
  List<CategoryModel> getCategory() {
    // TODO: implement getCategory
    throw UnimplementedError();
  }
  
}
