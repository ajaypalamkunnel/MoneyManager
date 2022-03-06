import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';

ValueNotifier<CategoryType> selectCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context) async {
  final _nameEditingController = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text('Add Category'),
          children: [
            //fprm field
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                  controller: _nameEditingController,
                  decoration: const InputDecoration(
                      hintText: 'Category Name',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo)))),
            ),
            //Radio button
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: const [
                  RadioButton(title: 'Income', type: CategoryType.income),
                  RadioButton(title: 'Expense', type: CategoryType.expense)
                ],
              ),
            ),
            //elevated button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  final _name = _nameEditingController.text;
                  if (_name.isEmpty) {
                    return;
                  }
                  final _type = selectCategoryNotifier.value;
                  final _category = CategoryModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: _name,
                      type: _type
                      );

                  CategoryDB.instance.insertCategory(_category);
                  Navigator.of(ctx).pop();
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.indigo.shade900, elevation: 3

                    //maximumSize: Size(20, 15)
                    ),
                child: const Text('Add'),
              ),
            )
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({Key? key, required this.title, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectCategoryNotifier,
          builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
            return Radio<CategoryType>(
              value: type,
              //selected category
              groupValue: newCategory,
              //selectCategoryNotifier.value,
              //clicked value in onchanged
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                selectCategoryNotifier.value = value;
                selectCategoryNotifier.notifyListeners();
              },
            );
          },
        ),
        Text(title),
      ],
    );
  }
}
