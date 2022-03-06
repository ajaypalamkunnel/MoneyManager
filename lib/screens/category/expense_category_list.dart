import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //screen for display expense
    return ValueListenableBuilder(
        valueListenable: CategoryDB().expenseCategoryListListner,
        builder: (BuildContext ctx, List<CategoryModel> newlist, Widget? _) {
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (ctx, index) {
              final Category = newlist[index];
              return Card(
                color: Colors.red,
                child: ListTile(
                  title: Text(
                    Category.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        CategoryDB.instance.deleteCategory(Category.id);
                      },
                      icon: const Icon(Icons.delete)),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(height: 10);
            },
            itemCount: newlist.length,
          );
        });
  }
}
