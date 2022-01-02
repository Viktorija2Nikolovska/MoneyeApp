// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:intl/intl.dart' as intl;
// import 'dart:core';
// import 'moneye_income.dart';
// import 'moneye_home.dart';

// class AddIncome extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _AddIncomeState();
//   }
// }

// class _AddIncomeState extends State<AddIncome> {
//   // void _addCustomExpenseCategory() {
//   //   Navigator.push(context, MaterialPageRoute(builder: (context) => AddExpenseCategory()));
//   // }
//   final incomeCategoryController = TextEditingController();

//   void _submitIncomeCategory() {
//     {
//       setState(() {
//         incomeCategories.add(
//           incomeCategoryController.text,
//         );

//         incomeCategoryController.text = "";
//       });
//     }
//   }

//   List<String> incomeCategories = [
//     "Salary",
//     "Bonus",
//   ];

//   String selectedCategory = "Salary";

//   final amountController = TextEditingController();
//   final dateController = TextEditingController();

//   DateTime createdOn = DateTime.now();
//   TimeOfDay createdOnTime = TimeOfDay.now();

//   void _onSubmit() {
//     setState(() {
//       IncomeState.addIncome(amountController.text, selectedCategory, dateController.text);

//       amountController.text = "";
//       selectedCategory = "Salary";
//       dateController.text = "";
//       createdOn = DateTime.now();
//     });
//   }

//   //"amount": "700EUR",
//   //     "workplace": "Netcetera",
//   //     "position": "Software Engineer"

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Expense'),
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
//                             labelText: 'Income Amount',
//                           ),
//                         ),
//                         Column(
//                           children: [
//                             DropdownButton<String>(
//                               value: selectedCategory,
//                               icon: const Icon(Icons.arrow_downward),
//                               elevation: 16,
//                               style: const TextStyle(color: Colors.deepPurple),
//                               underline: Container(
//                                 height: 2,
//                                 color: Colors.greenAccent[700],
//                               ),
//                               onChanged: (String newValue) {
//                                 setState(() {
//                                   selectedCategory = newValue;
//                                 });
//                               },
//                               items: incomeCategories.map<DropdownMenuItem<String>>((String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Text(value),
//                                 );
//                               }).toList(),
//                             )
//                           ],
//                         ),
//                         _FormDatePicker(
//                           date: createdOn,
//                           onChangedDate: (value) {
//                             setState(() {
//                               createdOn = value;

//                               // TimeOfDay now = TimeOfDay.now();

//                               // DODADI VREME !!!

//                               //date = "${date.toLocal().day}/${date.toLocal().month}/${date.toLocal().year}";
//                               String formattedDate = intl.DateFormat("dd/MM/yyyy").format(createdOn);

//                               dateController.text = formattedDate;
//                             });
//                           },
//                           // onChangedTime: (time) {
//                           //   setState(() {
//                           //     createdOnTime = time;

//                           //     final localizations = MaterialLocalizations.of(context);
//                           //     String formattedTime = localizations.formatTimeOfDay(createdOnTime);
//                           //     dateController.text = formattedTime;
//                           //   });
//                           // },
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
//                         child: const Text('Submit'),
//                         onPressed: _onSubmit,
//                       ),
//                       ElevatedButton(
//                         child: const Text('Add Income Category'),
//                         onPressed: _addCustomIncomeCategory,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _addCustomIncomeCategory() {
//     Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('Add Category'),
//         ),
//         body: Form(
//           child: Scrollbar(
//             child: Align(
//               alignment: Alignment.topCenter,
//               child: Card(
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.all(16),
//                   child: ConstrainedBox(
//                     constraints: const BoxConstraints(maxWidth: 400),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         ...[
//                           TextFormField(
//                             controller: incomeCategoryController,
//                             decoration: const InputDecoration(
//                               filled: true,
//                               hintText: 'Enter category',
//                               labelText: 'income Category',
//                             ),
//                           ),
//                         ].expand(
//                           (widget) => [
//                             widget,
//                             const SizedBox(
//                               height: 24,
//                             )
//                           ],
//                         ),
//                         ElevatedButton(
//                           child: const Text('Submit'),
//                           onPressed: _submitIncomeCategory,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     })); //Scaffold
//   }

//   // addEIncomeCategoryForm end
// }

// class _FormDatePicker extends StatefulWidget {
//   final DateTime date;
//   //final TimeOfDay time;
//   final ValueChanged<DateTime> onChangedDate;
//   // final ValueChanged<TimeOfDay> onChangedTime;

//   const _FormDatePicker({
//     this.date,
//     this.onChangedDate,
//     // this.time,
//     // this.onChangedTime,
//   });

//   @override
//   _FormDatePickerState createState() => _FormDatePickerState();
// }

// class _FormDatePickerState extends State<_FormDatePicker> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Text(
//               'Date ',
//               style: Theme.of(context).textTheme.bodyText1,
//             ),
//             Text(
//               intl.DateFormat.yMd().format(widget.date),
//               //+ widget.time.format(context),
//               style: Theme.of(context).textTheme.subtitle1,
//             ),
//           ],
//         ),
//         TextButton(
//           child: const Text('Edit'),
//           onPressed: () async {
//             var newDate = await showDatePicker(
//               context: context,
//               initialDate: widget.date,
//               firstDate: DateTime(1900),
//               lastDate: DateTime(2100),
//             );

//             // var newTime = await showTimePicker(
//             //   context: context,
//             //   initialTime: widget.time,
//             // );

//             // Don't change the date if the date picker returns null.
//             if (newDate == null) {
//               return;
//             }
//             // onChanged:
//             // (date, time) {
//             //   setState(() {
//             //     newDate = date;
//             //     newTime = time;
//             //   });
//             // };

//             widget.onChangedDate(newDate);
//             // widget.onChangedTime(newTime);
//           },
//         ),
//       ],
//     );
//   }
// }
