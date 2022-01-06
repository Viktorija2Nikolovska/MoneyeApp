import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:core';
import 'moneye_income.dart';
import 'moneye_home.dart';

class AddIncome extends StatefulWidget {
  final IncomeAddCallback incomeCallback;
  const AddIncome (this.incomeCallback);
  @override
  State<StatefulWidget> createState() {
    return _AddIncomeState(this.incomeCallback);
  }
}

class _AddIncomeState extends State<AddIncome> {
  IncomeAddCallback incomeCallback;
  _AddIncomeState(this.incomeCallback);
  

// "amount": "700EUR",
  //     "workplace": "Netcetera",
  //     "position": "Software Engineer"
  final amountController = TextEditingController();
  final workplaceController = TextEditingController();
  final positionController = TextEditingController();
 String date= DateFormat("dd/MM/yyyy kk:mm").format(DateTime.now());
 

  void _onSubmit() {
    incomeCallback(amountController.text,workplaceController.text,positionController.text,date);

    setState(() {

      amountController.text = "";
     
      workplaceController.text = "";
           positionController.text = "";
            date= DateFormat("dd/MM/yyyy kk:mm").format(DateTime.now());

    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Income successfully added.')),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Income Information'),
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
                            labelText: 'Income Amount',
                          ),
                        ),
                        TextFormField(
                          controller: workplaceController,
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: 'Enter workplace',
                            labelText: 'Workplace',
                          ),
                        ),
                        TextFormField(
                          controller: positionController,
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: 'Enter work position',
                            labelText: 'Work Position',
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
                        onPressed: _onSubmit,
                      ),
                      
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


  