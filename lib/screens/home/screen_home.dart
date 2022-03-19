import 'package:flutter/material.dart';
import 'package:money_manager/screens/add_tansactions/screen_add_transctions.dart';
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
            Navigator.of(context).pushNamed(ScreenaddTranscations.routeName);
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
