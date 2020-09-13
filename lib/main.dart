import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'utils.dart';
import './widgets/chart_card.dart';
import './models/covid_day.dart';
import './models/covid_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Chart App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, CovidState> covidStateData = new Map<String, CovidState>();
  Map<String, Widget> covidStateCharts = new Map<String, Widget>();
  List<dynamic> uniqueStateNames;

  void parseJson() async {
    String stateData = await loadStateData();

    //Cleaned Unique State Names : Each Name will have curve for itself
    uniqueStateNames = giveUniqueStateNames(json.decode(stateData)['data']);

    //Initializing Map
    uniqueStateNames.forEach((state) {
      covidStateData[state] = CovidState();
    });

    //Filling Map with Data
    (json.decode(stateData)['data'] as List).forEach((day) {
      (day['regional'] as List).forEach((state) {
        covidStateData[fixStateName(state['loc'])].stateName = state['loc'];
        covidStateData[fixStateName(state['loc'])].dayWiseScenerio.add(
              CovidDay(
                DateTime.parse(day['day']),
                state['totalConfirmed'],
                state['deaths'],
              ),
            );
      });
    });

    covidStateData.forEach((key, value) {
      setState(() {
        covidStateCharts[key] = ChartCard(
            covidStateData[key].stateName, covidStateData[key].dayWiseScenerio);
      });
    });
  }

  @override
  void initState() {
    parseJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: uniqueStateNames.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return covidStateCharts[uniqueStateNames[index]];
          }),
    );
  }
}
