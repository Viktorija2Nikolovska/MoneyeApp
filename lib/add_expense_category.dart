import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planner/moneye_add_expense.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:core';
import 'moneye_expenses.dart';
import 'moneye_home.dart';
import 'moneye_add_expense.dart';

class AddExpenseCategory extends StatefulWidget {

  final AddCustomExpenseCategory categoryCallback;

  const AddExpenseCategory(this.categoryCallback);

  @override
  State<StatefulWidget> createState() {
    return _AddExpenseCategoryState(categoryCallback);
  }
}

class _AddExpenseCategoryState extends State<AddExpenseCategory> {

 final expenseCategoryController = TextEditingController();

 AddCustomExpenseCategory categoryCallback;

 _AddExpenseCategoryState(this.categoryCallback);

 @override
  void initState() {
    super.initState();

    // ..
  }

 void _submitExpenseCategory() {
   categoryCallback(expenseCategoryController.text);

   setState(() {
     expenseCategoryController.text = "";
   });

   ScaffoldMessenger.of(context).showSnackBar(
     const SnackBar(content: Text('Category successfully added.')),
   );
  }

 // void _getExpenses() async {
 //   SharedPreferences preferences = await SharedPreferences.getInstance();
 //   if (preferences.containsKey("expenses")) {
 //     String jsonExpenses = preferences.getString("expenses");
 //     var listExpenses = jsonDecode(jsonExpenses);
 //     setState(() {
 //       expenses = listExpenses;
 //     });
 //   }
 // }
 //
 // // static void addExpense(String text1, String text2, String text3) {
 // //   expenses.add(value)
 // // }
 //
 // void _setExpenses() async {
 //   // ke se povikuva sekoj pat koga ke se dodade nov expense (noviot expense prvo ke se dodade vo listata, pa potoa ke se zacuva vo memorija)
 //   SharedPreferences preferences = await SharedPreferences.getInstance();
 //   if (preferences.containsKey("expenses")) {
 //     preferences.remove("expenses");
 //   }
 //   preferences.setString("expenses", jsonEncode(expenses));
 //   // _getExpenses();
 // }

 @override
  Widget build(BuildContext context) {

  return Scaffold(
        appBar: AppBar(
          title: const Text('Add Category'),
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
                            controller: expenseCategoryController,
                            decoration: const InputDecoration(
                              filled: true,
                              hintText: 'Enter category',
                              labelText: 'Expense Category',
                            ),
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
                            onPressed: _submitExpenseCategory),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
   } //Scaffold

}
