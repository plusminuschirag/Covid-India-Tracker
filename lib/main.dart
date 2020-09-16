import 'dart:convert';

import 'package:flutter/material.dart';

import 'utils.dart';
import './widgets/chart_card.dart';
import './models/covid_day.dart';
import './models/covid_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '🇮🇳  COVID-19 Cases'),
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
  Future<List<dynamic>> parseJson() async {
    String stateData = await loadStateData();

    //Cleaned Unique State Names : Each Name will have curve for itself
    uniqueStateNames = giveUniqueStateNames(json.decode(stateData)['data']);

    //Inserting India at Top
    uniqueStateNames.insert(0, "India");

    //Initializing Map for Each uniqueStateNames otherwise Null Error
    uniqueStateNames.forEach((state) {
      covidStateData[state] = CovidState();
    });

    //Filling Map with State Data
    (json.decode(stateData)['data'] as List).forEach((day) {
      (day['regional'] as List).forEach((state) {
        covidStateData[fixStateName(state['loc'])].stateName = state['loc'];
        covidStateData[fixStateName(state['loc'])].dayWiseScenerio.add(
              CovidDay(
                DateTime.parse(day['day']),
                state['totalConfirmed'],
                state['deaths'],
                state['discharged'],
              ),
            );
      });
    });

    (json.decode(stateData)['data'] as List).forEach((day) {
      covidStateData["India"].stateName = 'India';
      covidStateData["India"].dayWiseScenerio.add(
            CovidDay(
              DateTime.parse(day['day']),
              day['summary']['total'],
              day['summary']['deaths'],
              day['summary']['discharged'],
            ),
          );
    });

    covidStateData.forEach((key, value) {
      setState(() {
        covidStateCharts[key] = ChartCard(
            covidStateData[key].stateName, covidStateData[key].dayWiseScenerio);
      });
    });
    return uniqueStateNames;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: parseJson(),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return covidStateCharts[snapshot.data[index]];
                  });
            }
          }),
    );
  }
}
