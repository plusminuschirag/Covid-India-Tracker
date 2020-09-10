import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/covid_day.dart';

class ChartCard extends StatefulWidget {
  final List<CovidDay> covidDayList;

  ChartCard(this.covidDayList) {
    covidDayList.forEach((element) {
      print("Printing covidDayList");
      print("${element.date} : ${element.totalDeaths}");
    });
  }

  @override
  _ChartCardState createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15),
      elevation: 10,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ListTile(
                  leading: Text("🇮🇳", style: TextStyle(fontSize: 30)),
                  title: Text(
                    "COVID-19 India App",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          Card(
            margin: EdgeInsets.all(20),
            elevation: 5,
            child: SizedBox(
              height: 350,
              width: 350,
              child: Center(
                  child: Container(
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(),
                  series: <ChartSeries>[
                    LineSeries<CovidDay, String>(
                      dataSource: widget.covidDayList,
                      xValueMapper: (CovidDay covidDay, _) =>
                          covidDay.date.toString(),
                      yValueMapper: (CovidDay covidDay, _) =>
                          covidDay.totalCases,
                    ),
                  ],
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
