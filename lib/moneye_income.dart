import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_income.dart';

typedef IncomeAddCallback = void Function(
    String amount, String workplace, String position);

class Income extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IncomeState();
  }
}

class _IncomeState extends State<Income> {
  List<dynamic> incomeSources = [];
  List<dynamic> incomeList = [];

  // List<dynamic> incomeSources = [
  //   {
  //     "amount": "700EUR",
  //     "workplace": "Netcetera",
  //     "position": "Software Engineer"
  //   },
  //   {
  //     "amount": "500EUR",
  //     "workplace": "Freelance",
  //     "position": "Ethical Hacker"
  //   }
  // ];

  // List<dynamic> incomeList = [
  //   {
  //     "amount": "700EUR",
  //     "workplace": "Netcetera",
  //     "date": DateFormat("dd/MM/yyyy kk:mm").format(DateTime.now())
  //   },
  //   {
  //     "amount": "700EUR",
  //     "workplace": "Netcetera",
  //     "date": DateFormat("dd/MM/yyyy kk:mm").format(DateTime.now())
  //   },
  //   {
  //     "amount": "500EUR",
  //     "workplace": "Freelance",
  //     "date": DateFormat("dd/MM/yyyy kk:mm").format(DateTime.now())
  //   },
  //   {
  //     "amount": "500EUR",
  //     "workplace": "Freelance",
  //     "date": DateFormat("dd/MM/yyyy kk:mm").format(DateTime.now())
  //   }
  // ];

  @override
  void initState() {
    super.initState();
    _getIncomeSources();
    _getIncomeList();
  }

  void _addIncome(String amount, String workplace, String position) {
    setState(() {
      incomeSources.add(
          {"amount": amount, "workplace": workplace, "position": position});
    });

    _setIncomeSources();
  }

  void _showAddIncomeForm() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddIncome(_addIncome)));
  }

  void _getIncomeSources() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey("incomeSources")) {
      String jsonIncomeSources = preferences.getString("incomeSources");
      var listIncomeSources = jsonDecode(jsonIncomeSources);
      setState(() {
        incomeSources = listIncomeSources;
      });
    }
  }

  void _setIncomeSources() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey("incomeSources")) {
      preferences.remove("incomeSources");
    }
    preferences.setString("incomeSources", jsonEncode(incomeSources));
  }

  void _getIncomeList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey("incomeList")) {
      String jsonIncomeList = preferences.getString("incomeList");
      var decodedIncomeList = jsonDecode(jsonIncomeList);
      setState(() {
        incomeList = decodedIncomeList;
      });
    }
  }

  void _setIncomeList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey("incomeList")) {
      preferences.remove("incomeList");
    }
    preferences.setString("incomeList", jsonEncode(incomeList));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Income information", style: TextStyle(fontSize: 27))),
                  floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _showAddIncomeForm,
        ),
        body: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
              margin: EdgeInsets.only(top: 25),
              padding: EdgeInsets.only(bottom: 10, left: 15),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Income sources",
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)))),
          SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: ListView.builder(
                  itemCount: incomeSources.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: Column(children: [
                      ListTile(
                          leading: Icon(Icons.access_time_filled, size: 35),
                          title: Container(
                              child: Text(
                                  incomeSources[index]["amount"].toString(),
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold))),
                          subtitle: Text(
                              incomeSources[index]["workplace"].toString() +
                                  "\n" +
                                  incomeSources[index]["position"].toString(),
                              style: TextStyle(fontSize: 21)),
                          trailing: Container(
                              child: IconButton(
                                  icon: Icon(Icons.delete,
                                      color: Colors.red, size: 35),
                                  onPressed: () {
                                    setState(() {
                                      incomeSources.removeAt(index);
                                      _setIncomeSources();
                                    });
                                  })))
                    ]));
                  })),
          Container(
              margin: EdgeInsets.only(top: 50),
              padding: EdgeInsets.only(bottom: 10, left: 15, right: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Income logs",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      ElevatedButton(
                          child: Text("CLEAR", style: TextStyle(fontSize: 16)),
                          onPressed: () {
                            setState(() {
                              incomeList = [];
                              _setIncomeList();
                            });
                          },
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green))
                    ]),
              )),
          SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: ListView.builder(
                  itemCount: incomeList.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: Column(children: [
                      ListTile(
                          leading: Icon(Icons.access_time_filled, size: 35),
                          title: Container(
                              child: Text(
                                  incomeList[index]["amount"].toString(),
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold))),
                          subtitle: Text(
                              incomeList[index]["workplace"].toString() +
                                  "\n" +
                                  incomeList[index]["date"].toString(),
                              style: TextStyle(fontSize: 21)),
                          trailing: Container(
                              child: IconButton(
                                  icon: Icon(Icons.delete,
                                      color: Colors.red, size: 35),
                                  onPressed: () {
                                    setState(() {
                                      incomeList.removeAt(index);
                                      _setIncomeList();
                                    });
                                  })))
                    ]));
                  }))
        ]));
  }
}
