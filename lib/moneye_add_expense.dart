import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:core';
import 'moneye_home.dart';

class AddExpense extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  List<dynamic> expenses = [];
  List<dynamic> expenseCategories = [];

  String selectedCategory = "";
  //final valueController = TextEditingController();
  final amountController = TextEditingController();
  final categoryController = TextEditingController();
  final dateController = TextEditingController();

  DateTime date1 = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Expense'),
        ),
        body: Form(
          child: Scrollbar(
            child: Align(
              alignment: Alignment.topCenter,
              child: Card(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ...[
                          TextFormField(
                            controller: amountController,
                            decoration: const InputDecoration(
                              filled: true,
                              hintText: 'Enter amount',
                              labelText: 'Expense Amount',
                            ),
                          ),
                          Column(
                            children: [
                              DropdownButton(
                                // setState(() {
                                //   categoryController.text = selectedCategory;
                                // }),

                                //categoryController.text = selectedCategory,
                                underline: Container(),
                                hint: Center(
                                    child: Text(
                                      'Select the expense you love',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                icon: Icon(
                                  Icons.arrow_downward,
                                  color: Colors.yellow,
                                ),
                                isExpanded: true,
                                // The list of options
                                items: expenses
                                    .map((e) => DropdownMenuItem(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      e,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  value: e,
                                ))
                                    .toList(),

                                //customize the item

                                selectedItemBuilder: (BuildContext context) => expenses
                                    .map((e) => Center(
                                    child: Text(
                                      e,
                                      style: TextStyle(fontSize: 18, color: Colors.amber, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                                    )))
                                    .toList(),
                              ),
                            ],
                          ),
                          // _FormDatePicker(
                          //   date: date1,
                          //   onChanged: (value) {
                          //     setState(() {
                          //       date1 = value;
                          //
                          //       //date = "${date.toLocal().day}/${date.toLocal().month}/${date.toLocal().year}";
                          //       String formatedDate = intl.DateFormat('yyyy-MM-dd').format(date1);
                          //
                          //       dateController.text = formatedDate;
                          //     });
                          //   },
                          // ),
                        ].expand(
                              (widget) => [
                            widget,
                            const SizedBox(
                              height: 24,
                            )
                          ],
                        ),
                        ElevatedButton(
                            child: const Text('Submit'),
                            onPressed: () {
                              setState(() {
                                expenses.add({
                                  "amount": amountController.text,
                                  "category": categoryController.text,
                                  "date": dateController.text,
                                });
                                amountController.text = "";
                                categoryController.text = "";
                                dateController.text = "";
                                date1 = DateTime.now();
                              });
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }

}