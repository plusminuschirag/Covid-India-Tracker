import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../models/covid_day.dart';

class ChartCard extends StatelessWidget {
  final String stateName;
  final List<CovidDay> covidDayList;

  ChartCard(this.stateName, this.covidDayList);

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
                  leading: Text(stateName,
                      style: TextStyle(
                        fontSize: 30,
                      )),
                  title: Text(
                    covidDayList.last.totalCases.toString(),
                    style: TextStyle(fontSize: 20, color: Colors.red),
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
                child: SafeArea(
                  child: SfCartesianChart(
                    margin: EdgeInsets.all(10),
                    tooltipBehavior:
                        TooltipBehavior(enable: true, header: "${stateName}"),
                    primaryXAxis: CategoryAxis(),
                    primaryYAxis: NumericAxis(),
                    series: <ChartSeries>[
                      LineSeries<CovidDay, String>(
                        dataSource: covidDayList,
                        xValueMapper: (CovidDay covidDay, _) =>
                            DateFormat.yMMMd().format(covidDay.date).toString(),
                        yValueMapper: (CovidDay covidDay, _) =>
                            covidDay.totalCases,
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
