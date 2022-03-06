import 'package:flutter/material.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';

class ScreenaddTranscations extends StatelessWidget {
  static const routeName = 'add-transaction';
  const ScreenaddTranscations({Key? key}) : super(key: key);

  /*
  purpose
  Date
  Amount
  categoryType


  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Colors.indigo,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      // backgroundColor: Colors.grey[400],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            //purpose
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Purpose',
                  labelStyle: TextStyle(color: Colors.indigo)),
            ),

            //Amount
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(color: Colors.indigo)),
            ),
            //date
            TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.calendar_today),
                label: Text("Select Date")),
            //income/expense radio
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                        value: false,
                        groupValue: CategoryType.income,
                        onChanged: (newValue) {}),
                    Text("Income"),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: false,
                        groupValue: CategoryType.income,
                        onChanged: (newValue) {}),
                    Text("Expense"),
                  ],
                ),

                //drop down
              ],
            ),
            DropdownButton(
              hint: const Text('Setlect Category'),
              items: CategoryDB().expenseCategoryListListner.value.map((e) {
                return DropdownMenuItem(
                  value: e.id,
                  child: Text(e.name),
                );
              }).toList(),
              onChanged: (selectedValue) {
                print(selectedValue);
              },
            )
          ]),
        ),
      ),
    );
  }
}
