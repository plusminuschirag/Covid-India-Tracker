import 'package:covid_chart_app/charts/daily_log_cases.dart';
import 'package:flutter/material.dart';
import '../charts/daily_new_cases.dart';
import '../charts/daily_total_cases.dart';
import '../models/covid_day.dart';

class ChartState extends StatelessWidget {
  final String stateName;
  final List<CovidDay> covidDayList;

  ChartState(this.stateName, this.covidDayList);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          DailyTotalCases(stateName, covidDayList),
          DailyNewCases.generateDay(stateName, covidDayList),
          //DailyLogTotalCases(stateName, covidDayList),
        ],
      ),
    );
  }
}
