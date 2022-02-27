import 'package:flutter/material.dart';
import 'package:money_manager/screens/category/expense_category_list.dart';
import 'package:money_manager/screens/category/income_category_list.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({Key? key}) : super(key: key);

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  @override
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          padding: EdgeInsets.only(top: 4),
          indicator: BoxDecoration(
              color: Colors.indigo.shade900,
              //border: Border.all(color: Colors.indigo, width: 3),
              borderRadius: BorderRadius.circular(20)),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.indigo,
          tabs: const [
            Tab(
              text: 'INCOME',
            ),
            Tab(
              text: 'EXPENSE',
            ),
          ],
        ),
        Expanded(
          child: TabBarView(controller: _tabController, children: const [
            Center(child: IncomeCategoryList()),
            Center(child: ExpenseCategoryList())
          ]),
        )
      ],
    );
  }
}
