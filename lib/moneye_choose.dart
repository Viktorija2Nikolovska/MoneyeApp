import 'package:flutter/material.dart';

import 'moneye_add_expense.dart';

class MoneyeChoose extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MoneyeChooseState();
  }
}

class _MoneyeChooseState extends State<MoneyeChoose> {

  void _addExpense() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddExpense()));
  }
  //  void _addIncome() {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => AddIncome()));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Moneye", style: TextStyle(fontSize: 26)),
      ),
      body: Container(
        child: Column(
          children: [
            new ElevatedButton(
                child: Text(
                  "Add Income",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                onPressed: null), 

            new ElevatedButton(
                child: Text(
                  "Add Expense",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                onPressed: _addExpense), 
          ],
        ),
      ), 


    );
  }
}