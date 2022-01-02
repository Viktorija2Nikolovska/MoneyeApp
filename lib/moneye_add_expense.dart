import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:core';
import 'moneye_expenses.dart';
import 'moneye_home.dart';
import 'add_expense_category.dart';


typedef AddCustomExpenseCategory =void Function(String category);
class AddExpense extends StatefulWidget {
 
  @override
  State<StatefulWidget> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  ExpensesAddCallback callback;
 
  List<String> expenseCategories = ["Food", "Clothes", "Petrol", "Gym"];
  

  String selectedCategory = "Food";

  final amountController = TextEditingController();
  final dateController = TextEditingController();
 

  DateTime createdOn = DateTime.now();


void _addCustomExpenseCategory() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddExpenseCategory(addCustomExpenseCategory)));
  }

  void addCustomExpenseCategory(String category){
    setState(() {
      
      expenseCategories.add(
          category,
        );
    });
  }

  void _onSubmit() {
    callback(amountController.text, selectedCategory, dateController.text);

    setState(() {
      amountController.text = "";
      selectedCategory = "Food";
      dateController.text = "";
      createdOn = DateTime.now();
    });
  }

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
                              DropdownButton<String>(
                                value: selectedCategory,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style: const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    selectedCategory = newValue;
                                  });
                                },
                                items: expenseCategories
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )
                            ],
                          ),
                          _FormDatePicker(
                            date: createdOn,
                            onChanged: (value) {
                              setState(() {
                                createdOn = value;

                               

                                String formattedDate = intl.DateFormat('yyyy-MM-dd').format(createdOn);

                                dateController.text = formattedDate;
                              });
                            },
                          ),
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
                            onPressed: _onSubmit,
                        ),
                        ElevatedButton(
                            child: const Text('Add custom category'),
                            onPressed: _addCustomExpenseCategory,
                        )
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

class _FormDatePicker extends StatefulWidget {
  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  const _FormDatePicker({
    this.date,
    this.onChanged,
  });

  @override
  _FormDatePickerState createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<_FormDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Date',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              intl.DateFormat.yMd().format(widget.date),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        TextButton(
          child: const Text('Edit'),
          onPressed: () async {
            var newDate = await showDatePicker(
              context: context,
              initialDate: widget.date,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            // Don't change the date if the date picker returns null.
            if (newDate == null) {
              return;
            }
           
            widget.onChanged(newDate);
          },
        ),
      ],
    );
  }
}


