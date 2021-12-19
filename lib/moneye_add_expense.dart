import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:core';
import 'moneye_expenses.dart';
import 'moneye_home.dart';

class AddExpense extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  List<String> categories = ["Food", "Clothes", "Petrol", "Gym"];

  String selectedCategory = "Food";

  final amountController = TextEditingController();
  final dateController = TextEditingController();

  DateTime createdOn = DateTime.now();

  void _onSubmit() {
    // ExpensesState.addExpense(amountController.text, selectedCategory, dateController.text);

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
                                items: categories
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

                                // TimeOfDay now = TimeOfDay.now();

                                // DODADI VREME !!!

                                //date = "${date.toLocal().day}/${date.toLocal().month}/${date.toLocal().year}";
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
            // onChanged:
            // (value) {
            //   setState(() {
            //     newDate = value;
            //   });
            // };

            widget.onChanged(newDate);
          },
        ),
      ],
    );
  }
}


// void _addCustomCategory() {
//   Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Category'),
//       ),
//       body: Form(
//         child: Scrollbar(
//           child: Align(
//             alignment: Alignment.topCenter,
//             child: Card(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: ConstrainedBox(
//                   constraints: const BoxConstraints(maxWidth: 400),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       ...[
//                         TextFormField(
//                           controller: categoryController,
//                           decoration: const InputDecoration(
//                             filled: true,
//                             hintText: 'Enter category',
//                             labelText: 'Expense Amount',
//                           ),
//                         ),
//                       ].expand(
//                         (widget) => [
//                           widget,
//                           const SizedBox(
//                             height: 24,
//                           )
//                         ],
//                       ),
//                       ElevatedButton(
//                           child: const Text('Submit'),
//                           onPressed: () {
//                             setState(() {
//                               expenseCategories.add({
//                                 "category": categoryController.text,
//                               });
//
//                               categoryController.text = "";
//                             });
//                           }),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ); //Scaffold
//   }));
// } // addForm end
//


// void addExpenseValue() {
//   Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Expense'),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: _addCustomCategory,
//       ),
//       body: Form(
//         child: Scrollbar(
//           child: Align(
//             alignment: Alignment.topCenter,
//             child: Card(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: ConstrainedBox(
//                   constraints: const BoxConstraints(maxWidth: 400),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       ...[
//                         TextFormField(
//                           controller: amountController,
//                           decoration: const InputDecoration(
//                             filled: true,
//                             hintText: 'Enter amount',
//                             labelText: 'Expense Amount',
//                           ),
//                         ),
//                         Column(
//                           children: [
//                             DropdownButton(
//                               // setState(() {
//                               //   categoryController.text = selectedCategory;
//                               // }),
//
//                               //categoryController.text = selectedCategory,
//                               underline: Container(),
//                               hint: Center(
//                                   child: Text(
//                                 'Select the expense you love',
//                                 style: TextStyle(color: Colors.white),
//                               )),
//                               icon: Icon(
//                                 Icons.arrow_downward,
//                                 color: Colors.yellow,
//                               ),
//                               isExpanded: true,
//                               // The list of options
//                               items: expenses
//                                   .map((e) => DropdownMenuItem(
//                                         child: Container(
//                                           alignment: Alignment.centerLeft,
//                                           child: Text(
//                                             e,
//                                             style: TextStyle(fontSize: 18),
//                                           ),
//                                         ),
//                                         value: e,
//                                       ))
//                                   .toList(),
//
//                               //customize the item
//
//                               selectedItemBuilder: (BuildContext context) => expenses
//                                   .map((e) => Center(
//                                           child: Text(
//                                         e,
//                                         style: TextStyle(fontSize: 18, color: Colors.amber, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
//                                       )))
//                                   .toList(),
//                             ),
//                           ],
//                         ),
//                         _FormDatePicker(
//                           date: date1,
//                           onChanged: (value) {
//                             setState(() {
//                               date1 = value;
//
//                               //date = "${date.toLocal().day}/${date.toLocal().month}/${date.toLocal().year}";
//                               String formatedDate = intl.DateFormat('yyyy-MM-dd').format(date1);
//
//                               dateController.text = formatedDate;
//                             });
//                           },
//                         ),
//                       ].expand(
//                         (widget) => [
//                           widget,
//                           const SizedBox(
//                             height: 24,
//                           )
//                         ],
//                       ),
//                       ElevatedButton(
//                           child: const Text('Submit'),
//                           onPressed: () {
//                             setState(() {
//                               expenses.add({
//                                 "amount": amountController.text,
//                                 "category": categoryController.text,
//                                 "date": dateController.text,
//                               });
//                               amountController.text = "";
//                               categoryController.text = "";
//                               dateController.text = "";
//                               date1 = DateTime.now();
//                             });
//                           }),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ); //Scaffold
//   }));
// } // addForm end