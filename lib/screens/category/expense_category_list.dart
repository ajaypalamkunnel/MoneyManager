import 'package:flutter/material.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(10),
      itemBuilder: (ctx, index) {
        return Card(
          color: Colors.red,
          child: ListTile(
            title: Text(
              'Expense category $index',
              style: TextStyle(color: Colors.white),
            ),
            trailing: IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
          ),
        );
      },
      separatorBuilder: (ctx, index) {
        return const SizedBox(height: 10);
      },
      itemCount: 100,
    );
  }
}
