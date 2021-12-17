import 'package:flutter/material.dart';

import 'moneye_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moneye',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Moneye(),
    );
  }
}
