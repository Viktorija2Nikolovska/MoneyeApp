import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Statistics extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StatisticsState();
  }
}

class _StatisticsState extends State<Statistics> {
  // Vrednostite vo mapite vo ovaa klasa ke treba da se izveduvaat vrz baza na samite expenses i income.
  // Na primer za Clothes trosoci da ima funkcija vo Expenses widget-ot koja ke gi selektira site trosoci za kategorija "Clothes" i ke gi parsira nivnite sumi vo double, pritoa smestuvajki
  // gi vo sumarna promenliva koja ke se vrakja kako rezultat na funkcijata i ke se smestuva vo "Clothes" vrednosta na expensesMap.
  // So ova ke se namali koristenjeto na SharedPreferences.

  Map<String, double> expensesMap = {
    "Clothes": 500,
    "Food": 800,
    "Petrol": 1000,
    "Gym": 2000
  };

  Map<String, double> incomeMap = {
    "Netcetera": 3,
    "Freelance": 2
  };

  List<Color> expensesColorList = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.green
  ];
  List<Color> incomeColorList = [
    Colors.green,
    Colors.greenAccent
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Statistics", style: TextStyle(fontSize: 27))),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 11.5), padding: EdgeInsets.only(bottom: 10, left: 15), child: Align(alignment: Alignment.topLeft, child: Text("Expenses", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)))),
            Container(
              margin: EdgeInsets.only(top: 45),
              child: PieChart(
                  dataMap: expensesMap,
                  animationDuration: Duration(milliseconds: 1300),
                  chartLegendSpacing: 32,
                  chartRadius: MediaQuery.of(context).size.width / 1.9,
                  colorList: expensesColorList,
                  initialAngleInDegree: 0,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 30,
                  legendOptions: LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.right,
                    showLegends: true,
                    legendShape: BoxShape.circle,
                    legendTextStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  chartValuesOptions: ChartValuesOptions(showChartValueBackground: true, showChartValues: true, showChartValuesInPercentage: true, showChartValuesOutside: false, decimalPlaces: 2, chartValueStyle: TextStyle(color: Colors.black, backgroundColor: Colors.white, fontSize: 16, fontWeight: FontWeight.bold), chartValueBackgroundColor: Colors.white)),
            ),
            Container(margin: EdgeInsets.only(top: 75), padding: EdgeInsets.only(bottom: 10, left: 15), child: Align(alignment: Alignment.topLeft, child: Text("Income", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)))),
            Container(
              margin: EdgeInsets.only(top: 45),
              child: PieChart(
                  dataMap: incomeMap,
                  animationDuration: Duration(milliseconds: 1300),
                  chartLegendSpacing: 32,
                  chartRadius: MediaQuery.of(context).size.width / 1.9,
                  colorList: incomeColorList,
                  initialAngleInDegree: 0,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 30,
                  legendOptions: LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.right,
                    showLegends: true,
                    legendShape: BoxShape.circle,
                    legendTextStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  chartValuesOptions: ChartValuesOptions(showChartValueBackground: true, showChartValues: true, showChartValuesInPercentage: true, showChartValuesOutside: false, decimalPlaces: 2, chartValueStyle: TextStyle(color: Colors.black, backgroundColor: Colors.white, fontSize: 16, fontWeight: FontWeight.bold), chartValueBackgroundColor: Colors.white)),
            )
          ],
        ));
  }
}
