import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';

import './widgets/chart_card.dart';
import './models/covid_day.dart';

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

  Future<String> _loadFromAsset() async {
    return await rootBundle.loadString("assets/covid_19_national.json");
  }

  void parseJson() async {
    String jsonString = await _loadFromAsset();
    List<dynamic> covidNationalData = json.decode(jsonString);

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
      body: Column(
        children: [
          Container(
            child: ChartCard(covidDailyCases),
          ),
        ],
      ),
    );
  }
}
