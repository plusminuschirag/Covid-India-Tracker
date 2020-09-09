import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

import './widgets/chart_card.dart';

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
  var covidNationalData;

  Future<String> _loadFromAsset() async {
    return await rootBundle.loadString("assets/covid_19_national.json");
  }

  Future parseJson() async {
    String jsonString = await _loadFromAsset();
    covidNationalData = json.decode(jsonString);
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
            child: ChartCard(),
          ),
          Center(
            child: RaisedButton(
              child: Text('Click me'),
              onPressed: () => {parseJson()},
            ),
          ),
        ],
      ),
    );
  }
}
