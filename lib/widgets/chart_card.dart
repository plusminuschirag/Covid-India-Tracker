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
                  title: Row(
                    children: [
                      Text(
                        covidDayList.last.totalCases.toString(),
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.arrow_upward,
                        color: Colors.redAccent,
                        size: 15,
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                      Text(
                        covidDayList.last.totalDischarged.toString(),
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.arrow_downward,
                        color: Colors.greenAccent,
                        size: 15,
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                      Text(
                        covidDayList.last.totalDeaths.toString(),
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.airline_seat_flat,
                        color: Colors.grey,
                        size: 15,
                      ),
                    ],
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
                    legend: Legend(
                      isVisible: true,
                    ),
                    margin: EdgeInsets.all(10),
                    tooltipBehavior:
                        TooltipBehavior(enable: true, header: stateName),
                    primaryXAxis: CategoryAxis(),
                    primaryYAxis: NumericAxis(),
                    palette: <Color>[
                      Colors.red,
                      Colors.teal,
                    ],
                    series: <ChartSeries>[
                      LineSeries<CovidDay, String>(
                        name: 'Cases',
                        dataSource: covidDayList,
                        xValueMapper: (CovidDay covidDay, _) =>
                            DateFormat.yMMMd().format(covidDay.date).toString(),
                        yValueMapper: (CovidDay covidDay, _) =>
                            covidDay.totalCases,
                      ),
                      LineSeries<CovidDay, String>(
                        name: 'Discharged',
                        dataSource: covidDayList,
                        xValueMapper: (CovidDay covidDay, _) =>
                            DateFormat.yMMMd().format(covidDay.date).toString(),
                        yValueMapper: (CovidDay covidDay, _) =>
                            covidDay.totalDischarged,
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
