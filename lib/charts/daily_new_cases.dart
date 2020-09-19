import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../models/covid_day.dart';

var indianNumberFormat = NumberFormat.compact(locale: 'en_IN');

class DailyNewCases extends StatelessWidget {
  final String stateName;
  final List<CovidDay> covidDayList;
  final List<CovidDay> covidPerDayList;

  DailyNewCases(this.stateName, this.covidDayList, this.covidPerDayList);

  factory DailyNewCases.generateDay(
      String stateName, List<CovidDay> covidDayList) {
    List<CovidDay> covidPerDayList = new List<CovidDay>();
    List<CovidDay> covidDayShifted = new List.from(covidDayList);

    covidDayShifted.insert(
        0,
        CovidDay(
            date: covidDayShifted[0].date,
            totalCases: 0,
            totalDeaths: 0,
            totalDischarged: 0));

    for (var idx = 0; idx < covidDayList.length; idx++) {
      covidPerDayList.add(CovidDay(
        date: covidDayList[idx].date,
        totalCases:
            covidDayList[idx].totalCases - covidDayShifted[idx].totalCases,
        totalDeaths:
            covidDayList[idx].totalDeaths - covidDayShifted[idx].totalDeaths,
        totalDischarged: covidDayList[idx].totalDischarged -
            covidDayShifted[idx].totalDischarged,
      ));
    }

    return DailyNewCases(stateName, covidDayList, covidPerDayList);
  }

  createAlertDialog(
      BuildContext context, String stateName, List<CovidDay> covidPerDayList) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: [
              Text(
                stateName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FittedBox(
                child: Row(
                  children: [
                    Text(
                      'Date',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                    Text(
                      'Cases',
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
                      'Discharged',
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
                      'Deaths',
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
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 200,
                width: MediaQuery.of(context).size.width - 100,
                child: ListView.builder(
                  itemCount: covidPerDayList.length,
                  itemBuilder: (context, index) {
                    return FittedBox(
                      child: Row(
                        children: [
                          Container(
                            width: (MediaQuery.of(context).size.width - 100) *
                                0.25,
                            child: Text(
                              DateFormat.yMMMd()
                                  .format(covidPerDayList[index].date)
                                  .toString(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          Text(
                            indianNumberFormat
                                .format(covidPerDayList[index].totalCases),
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          Text(
                            indianNumberFormat
                                .format(covidPerDayList[index].totalDischarged),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          Text(
                            indianNumberFormat
                                .format(covidPerDayList[index].totalDeaths),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
                  leading: Text("New : $stateName",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                  title: GestureDetector(
                    onTap: () {
                      createAlertDialog(context, stateName, covidPerDayList);
                    },
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        children: [
                          Text(
                            indianNumberFormat
                                .format(covidPerDayList.last.totalCases),
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.arrow_upward,
                            color: Colors.redAccent,
                            size: 20,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10)),
                          Text(
                            indianNumberFormat
                                .format(covidPerDayList.last.totalDischarged),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.arrow_downward,
                            color: Colors.greenAccent,
                            size: 20,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10)),
                          Text(
                            indianNumberFormat
                                .format(covidPerDayList.last.totalDeaths),
                            style: TextStyle(
                              fontSize: 20,
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
                        dataSource: covidPerDayList,
                        xValueMapper: (CovidDay covidDay, _) =>
                            DateFormat.yMMMd().format(covidDay.date).toString(),
                        yValueMapper: (CovidDay covidDay, _) =>
                            covidDay.totalCases,
                      ),
                      LineSeries<CovidDay, String>(
                        name: 'Discharged',
                        dataSource: covidPerDayList,
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
