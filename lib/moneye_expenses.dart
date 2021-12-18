import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:core';
import 'moneye_home.dart';

class Expenses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  List<dynamic> expenses = [];
  List<dynamic> expenseCategories = [];

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
                      title: Container(margin: EdgeInsets.only(bottom: 10), child: Text(expenses[index]["amount"].toString(), style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold))),
                      subtitle: Text(expenses[index]["category"].toString() + "\n" + expenses[index]["date"].toString(), style: TextStyle(fontSize: 21)),
                      trailing: Container(
                          child: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red, size: 35),
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
