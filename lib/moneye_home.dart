import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'moneye_expenses.dart';
import 'moneye_income.dart';
import 'moneye_statistics.dart';

class Moneye extends StatefulWidget {
  @override
  State<Moneye> createState() => _MoneyeState();
}

class _MoneyeState extends State<Moneye> {
  String date = DateFormat("dd/MM/yyyy kk:mm").format(DateTime.now());

  void _listExpenses() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Expenses()));
  }

  void _showIncomeInformation() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Income()));
  }

  void _showStatistics() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Statistics()));
  }

  void _clearPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  void _chooseBetween() {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Moneye", style: TextStyle(fontSize: 26)),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new ElevatedButton(
                  child: Text(
                    "Add Income",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: null), // elevated button

              new ElevatedButton(
                  child: Text(
                    "Add Expense",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: ExpensesState.addExpenseValue), // elevated button
            ],
          ),
        ), //container

        //body:Column(

//           TextButton(
//   style: ButtonStyle(
//     foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//   ),
//   onPressed: null,
//   child: Text('addIncome'),
// ),

//);
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    _clearPreferences();
    return Scaffold(
        appBar: AppBar(
          title: Text("Moneye", style: TextStyle(fontSize: 26)),
          actions: [
            Tooltip(
                message: "View list of expenses",
                child: IconButton(
                  icon: Icon(Icons.money),
                  onPressed: _listExpenses,
                )),
            Tooltip(
                message: "View income information",
                child: IconButton(
                  icon: Icon(Icons.monetization_on),
                  onPressed: _showIncomeInformation,
                )),
            Tooltip(
                message: "View statistics",
                child: IconButton(
                  icon: Icon(Icons.equalizer),
                  onPressed: _showStatistics,
                )),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: IconButton(
                iconSize: 30,
                icon: Icon(Icons.circle_notifications),
                onPressed: null,
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _chooseBetween,
        ),
        body: Container(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(margin: EdgeInsets.only(bottom: 75), child: Center(child: Text(date, style: TextStyle(fontSize: 15)))),
              Container(margin: EdgeInsets.only(bottom: 15), child: Text("Expenses (this month): ", style: TextStyle(fontSize: 25))),
              Container(margin: EdgeInsets.only(bottom: 105), child: Text("Income (this month): ", style: TextStyle(fontSize: 25))),
              Container(margin: EdgeInsets.only(bottom: 75), child: Text("Balance: ", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold))),
              Container(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                          minVerticalPadding: 20,
                          leading: Icon(Icons.attach_money, size: 50),
                          title: Text("Budget: ", style: TextStyle(fontSize: 24)),
                          subtitle: Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: LinearPercentIndicator(
                                width: MediaQuery.of(context).size.width - 200,
                                animation: true,
                                lineHeight: 25,
                                animationDuration: 2000,
                                percent: 0.9,
                                center: Text("90.0%", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                linearStrokeCap: LinearStrokeCap.roundAll,
                                progressColor: Colors.greenAccent,
                              ))),
                      IconButton(icon: Icon(Icons.create_rounded), onPressed: null)
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25),
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                          minVerticalPadding: 20,
                          leading: Icon(Icons.lock, size: 50),
                          title: Text("Saving amount: ", style: TextStyle(fontSize: 24)),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width - 200,
                              animation: true,
                              lineHeight: 25,
                              animationDuration: 2000,
                              percent: 0.3,
                              center: Text("30.0%", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: Colors.blue,
                            ),
                          )),
                      IconButton(icon: Icon(Icons.create_rounded), onPressed: null)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
