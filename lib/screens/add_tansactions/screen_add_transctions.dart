import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';

class ScreenaddTranscations extends StatefulWidget {
  static const routeName = 'add-transaction';
  const ScreenaddTranscations({Key? key}) : super(key: key);

  @override
  State<ScreenaddTranscations> createState() => _ScreenaddTranscationsState();
}

class _ScreenaddTranscationsState extends State<ScreenaddTranscations> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategorytype;
  CategoryModel? _selectedCategorymodel;
  String? _categoryID;

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    _selectedCategorytype = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade300,
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 20),
                        //purpose
                        TextFormField(
                          controller: _purposeTextEditingController,
                          decoration: const InputDecoration(
                              labelText: 'Purpose',
                              labelStyle: TextStyle(color: Colors.indigo)),
                        ),

                        //Amount
                        TextFormField(
                          controller: _amountTextEditingController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              labelText: 'Amount',
                              labelStyle: TextStyle(color: Colors.indigo)),
                        ),
                        //date

                        TextButton.icon(
                            onPressed: () async {
                              final _selectedDateTemp = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now()
                                      .subtract(Duration(days: 30)),
                                  lastDate: DateTime.now());
                              if (_selectedDateTemp == null) {
                                return;
                              } else {
                                print(_selectedDateTemp.toString());
                                setState(() {
                                  _selectedDate = _selectedDateTemp;
                                });
                              }
                            },
                            icon: Icon(Icons.calendar_today),
                            label: Text(
                              _selectedDate == null
                                  ? "Select Date"
                                  : _selectedDate.toString(),
                              style: TextStyle(color: Colors.indigo),
                            )),
                        //income/expense radio
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Radio(
                                    value: CategoryType.income,
                                    groupValue: _selectedCategorytype,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedCategorytype =
                                            CategoryType.income;
                                        _categoryID = null;
                                      });
                                    }),
                                const Text(
                                  "Income",
                                  style: TextStyle(color: Colors.indigo),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: CategoryType.expense,
                                    groupValue: _selectedCategorytype,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedCategorytype =
                                            CategoryType.expense;
                                        _categoryID = null;
                                      });
                                    }),
                                const Text(
                                  "Expense",
                                  style: TextStyle(color: Colors.indigo),
                                )
                              ],
                            ),

                            //drop down
                          ],
                        ),
                        DropdownButton(
                          style: TextStyle(color: Colors.indigo),
                          hint: const Text('Setlect Category'),
                          value: _categoryID,
                          items: (_selectedCategorytype == CategoryType.income
                                  ? CategoryDB().incomeCategoryListListner
                                  : CategoryDB().expenseCategoryListListner)
                              .value
                              .map((e) {
                            return DropdownMenuItem(
                              value: e.id,
                              child: Text(e.name),
                            );
                          }).toList(),
                          onChanged: (selectedValue) {
                            print(selectedValue);
                            setState(() {
                              _categoryID = selectedValue as String?;
                            });
                          },
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.indigo)),
                            onPressed: () {},
                            child: const Text('Add Transaction'))
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;
  }
}
