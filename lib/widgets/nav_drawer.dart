import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../screen/state_screen.dart';
import '../models/covid_state.dart';

var indianNumberFormat = NumberFormat.compact(locale: 'en_IN');

getArrowIcon(int yesterday, int dayBeforeYesterday) {
  if (yesterday - dayBeforeYesterday > 0) {
    return Icons.arrow_upward;
  } else {
    return Icons.arrow_downward;
  }
}

class NavDrawerTile extends StatelessWidget {
  final String stateName;
  final CovidState stateData;

  NavDrawerTile({@required this.stateName, @required this.stateData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    StateScreen(stateName: stateName, stateData: stateData)));
      },
      child: Card(
        elevation: 5,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
          ),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text(stateName,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold))),
                Flexible(
                  child: Text(
                    stateData.dayWiseScenerio.last.totalCases != 0
                        ? "${((stateData.dayWiseScenerio.last.totalDischarged / stateData.dayWiseScenerio.last.totalCases) * 100).toStringAsFixed(2)}%"
                        : "No Cases",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                  child: Text(
                    stateData.dayWiseScenerio.last.totalCases != 0
                        ? "${((stateData.dayWiseScenerio.last.totalDeaths / stateData.dayWiseScenerio.last.totalCases) * 100).toStringAsFixed(2)}%"
                        : "No Deaths",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${indianNumberFormat.format(stateData.dayWiseScenerio.last.totalCases)}",
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
                  "${indianNumberFormat.format(stateData.dayWiseScenerio.last.totalDischarged)}",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.arrow_downward,
                  color: Colors.green,
                  size: 15,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                Text(
                  "${indianNumberFormat.format(stateData.dayWiseScenerio.last.totalDeaths)}",
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
            ),
            //
            // DAILY BASIS
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "(${indianNumberFormat.format((stateData.dayWiseScenerio[stateData.dayWiseScenerio.length - 2].totalCases - stateData.dayWiseScenerio[stateData.dayWiseScenerio.length - 3].totalCases).abs())})",
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  getArrowIcon(
                      stateData
                              .dayWiseScenerio[
                                  stateData.dayWiseScenerio.length - 2]
                              .totalCases -
                          stateData
                              .dayWiseScenerio[
                                  stateData.dayWiseScenerio.length - 3]
                              .totalCases,
                      stateData
                              .dayWiseScenerio[
                                  stateData.dayWiseScenerio.length - 3]
                              .totalCases -
                          stateData
                              .dayWiseScenerio[
                                  stateData.dayWiseScenerio.length - 4]
                              .totalCases),
                  color: Colors.redAccent,
                  size: 13,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                Text(
                  "(${indianNumberFormat.format((stateData.dayWiseScenerio[stateData.dayWiseScenerio.length - 2].totalDischarged - stateData.dayWiseScenerio[stateData.dayWiseScenerio.length - 3].totalDischarged).abs())})",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  getArrowIcon(
                      stateData
                              .dayWiseScenerio[
                                  stateData.dayWiseScenerio.length - 2]
                              .totalDischarged -
                          stateData
                              .dayWiseScenerio[
                                  stateData.dayWiseScenerio.length - 3]
                              .totalDischarged,
                      stateData
                              .dayWiseScenerio[
                                  stateData.dayWiseScenerio.length - 3]
                              .totalDischarged -
                          stateData
                              .dayWiseScenerio[
                                  stateData.dayWiseScenerio.length - 4]
                              .totalDischarged),
                  color: Colors.green,
                  size: 13,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                Text(
                  "(${indianNumberFormat.format((stateData.dayWiseScenerio[stateData.dayWiseScenerio.length - 2].totalDeaths - stateData.dayWiseScenerio[stateData.dayWiseScenerio.length - 3].totalDeaths).abs())})",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  getArrowIcon(
                      stateData
                              .dayWiseScenerio[
                                  stateData.dayWiseScenerio.length - 2]
                              .totalDeaths -
                          stateData
                              .dayWiseScenerio[
                                  stateData.dayWiseScenerio.length - 3]
                              .totalDeaths,
                      stateData
                              .dayWiseScenerio[
                                  stateData.dayWiseScenerio.length - 3]
                              .totalDeaths -
                          stateData
                              .dayWiseScenerio[
                                  stateData.dayWiseScenerio.length - 4]
                              .totalDeaths),
                  color: Colors.grey,
                  size: 13,
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
