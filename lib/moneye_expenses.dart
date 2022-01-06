import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planner/moneye_add_expense.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:core';
import 'moneye_home.dart';

typedef ExpensesAddCallback = void Function(String amount, String category, String date);

class Expenses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ExpensesState();
  }
}

class ExpensesState extends State<Expenses> {
  List<dynamic> expenses = [];
 // List<dynamic> expenseCategories = [];

  // === privremena implementacija ===

  @override
  void initState() {
  
    _setExpenses();
    _getExpenses();
      super.initState();
    
    
  }

  void _getExpenses() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey("expenses")) {
      String jsonExpenses = preferences.getString("expenses");
      var listExpenses = jsonDecode(jsonExpenses);
      setState(() {
        expenses = listExpenses;
      });
    }
  }



  void _setExpenses() async {
    // ke se povikuva sekoj pat koga ke se dodade nov expense (noviot expense prvo ke se dodade vo listata, pa potoa ke se zacuva vo memorija)
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey("expenses")) {
      preferences.remove("expenses");
    }
    preferences.setString("expenses", jsonEncode(expenses));
    // _getExpenses();
  }

  void _addExpense(String amount, String category, String date) {
    setState(() {
      expenses.add({"amount": amount, "category": category, "date": date});
    });

   _setExpenses();
  }

  // Koga ke se dodava nov expense, ke ima povik kon funkcija od ovoj widget koja ke prima tri parametri (amount, category i date) i istata ke dodava nova stavka vo listata, po sto ke
  // se povika _setExpenses() za perzistiranje vo memorija. Togas ke se trgne povikot do _getExpenses od _setExpenses funkcijata, a _getExpenses() ke se povikuva samo vo initState().

  // Idejata e inicijalno od memorija da se vcitaat stavkite, a ne da bidat hard kodirani. Kako sto se dodavaat novi ili se brisat postoecki, taka ke se povikuva _setExpenses() metodot
  // i ke se azuriraat stavkite vo memorija, no nema da bidat povtorno prezemani od memorija bidejki vekje postojat vo listata (bile prezemani vo initState ili pri brisenje, direktno izbrisani od listata)

  // var expenses = [
  //   {
  //     "amount": "125.50MKD",
  //     "category": "Food",
  //     "date": DateFormat("dd/MM/yyyy kk:mm").format(DateTime.now())
  //   },
  //   {
  //     "amount": "1500.00MKD",
  //     "category": "Clothes",
  //     "date": DateFormat("dd/MM/yyyy kk:mm").format(DateTime.now())
  //   },
  //   {
  //     "amount": "1000.00MKD",
  //     "category": "Petrol",
  //     "date": DateFormat("dd/MM/yyyy kk:mm").format(DateTime.now())
  //   }
  // ];

  // ====== ======

  void _showAddExpenseForm() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddExpense(_addExpense)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List of expenses", style: TextStyle(fontSize: 25)),
          actions: [
            ElevatedButton(
                child: Text("CLEAR", style: TextStyle(fontSize: 16)),
                onPressed: () {
                  setState(() {
                    expenses = [];
                    // _setExpenses();
                  });
                })
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _showAddExpenseForm,
        ),
        body: ListView.builder(
          itemCount: expenses.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // po vertikalna oska, bidejki e kolona, kolku da bide istata dolga. Ako se stavi min, dolzinata ke bide ednakva na taa dolzina sto ja zafakjaat decata (children)
                children: [
                  ListTile(
                      minVerticalPadding: 15,
                      leading: Icon(Icons.access_time_filled, size: 35),
                      title: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(expenses[index]["amount"].toString(),
                              style: TextStyle(
                                  fontSize: 27, fontWeight: FontWeight.bold))),
                      subtitle: Text(
                          expenses[index]["category"].toString() +
                              "\n" +
                              expenses[index]["date"].toString(),
                          style: TextStyle(fontSize: 21)),
                      trailing: Container(
                          child: IconButton(
                              icon: Icon(Icons.delete,
                                  color: Colors.red, size: 35),
                              onPressed: () {
                                setState(() {
                                  expenses.removeAt(index);
                                  // _setExpenses();
                                });
                              }))),
                ],
              ),
            );
          },
        ));
  }
}
