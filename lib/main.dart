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
  List<CovidDay> covidDailyCases = new List<CovidDay>();
  Map<String, CovidState> covidStateData = new Map<String, CovidState>();

  void parseJson() async {
    String covidData = await loadIndiaJson();
    String stateData = await loadStateData();

    List<dynamic> covidNationalData = json.decode(covidData);
    //Cleaned Unique State Names : Each Name will have curve for itself
    List<dynamic> uniqueStateNames =
        giveUniqueStateNames(json.decode(stateData)['data']);

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
      print(key);
      value.dayWiseScenerio.forEach((element) {
        print(element.date);
      });
    });

    covidNationalData.forEach((element) {
      setState(() {
        covidDailyCases.add(CovidDay(
          DateTime.parse(element['date']),
          element['total'],
          element['deaths'],
        ));
      });
    });
  }

  @override
  void initState() {
    parseJson();
    covidDailyCases.forEach((element) {
      print(
          "${DateFormat.yMMMd().format(element.date)} : ${element.totalCases}");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          Container(
            child: ChartCard(covidDailyCases),
          ),
          Center(
            child: RaisedButton(
              child: Text("Hey Button's here!"),
              onPressed: () {
                print("Hey Hello How are you");
              },
            ),
          )
        ],
      ),
    );
  }
}
