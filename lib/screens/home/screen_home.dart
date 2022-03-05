import 'package:flutter/material.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/screens/category/add_category_popup.dart';
import 'package:money_manager/screens/category/screen_category.dart';
import 'package:money_manager/screens/home/widgets/bottom_navigation.dart';
import 'package:money_manager/screens/transactions/screen_transactions.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [ScreenTransactions(), ScreenCategory()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        title: Text('Money Manger'),
      ),
      bottomNavigationBar: MoneyManagerBottomNavigation(),
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: selectedIndexNotifier,
              builder: (BuildContext context, int updatedIndex, _) {
                return _pages[updatedIndex];
              })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo.shade900,
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            print('Add transactions');
          } else {
            print('Add category');
            showCategoryAddPopup(context);
            // final _sample = CategoryModel(
            //     id: DateTime.now().millisecondsSinceEpoch.toString(),
            //     name: 'Travel',
            //     type: CategoryType.expense);
            // CategoryDB().insertCategory(_sample);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
