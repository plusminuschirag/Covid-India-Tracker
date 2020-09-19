import 'package:flutter/material.dart';

import '../models/covid_state.dart';
import '../widgets/chart_state.dart';

class StateScreen extends StatelessWidget {
  final String stateName;
  final CovidState stateData;

  StateScreen({@required this.stateName, @required this.stateData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.stateName),
        ),
        body: ListView(
          children: [ChartState(stateName, stateData.dayWiseScenerio)],
        ));
  }
}
