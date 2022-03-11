import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/db/category/transaction_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/models/transactions/transactions_list.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotfier,
      builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
        return ListView.separated(
          padding: EdgeInsets.all(10),
          itemBuilder: (ctx, index) {
            final _value = newList[index];
            return Slidable(
              key: Key(_value.id!),
              startActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                      backgroundColor: Colors.red,
                      onPressed: (ctx) {
                        TransactionDB.instance.deleteTransaction(_value.id!);
                      },
                      icon: Icons.delete,
                      label: 'Delete')
                ],
              ),
              child: Card(
                color: Colors.indigo.shade500,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 50,
                    backgroundColor: _value.type == CategoryType.income
                        ? Colors.green
                        : Colors.red,
                    child: Text(
                      parseDate(_value.date),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  title: Text(
                    'Rs ${_value.amount}',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    _value.category.name,
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
                    _value.purpose,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return SizedBox(
              height: 10,
            );
          },
          itemCount: newList.length,
        );
      },
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');
    return '${_splitedDate.last} \n ${_splitedDate.first}';
    //return '${date.day}\n${date.month}';
  }
}
