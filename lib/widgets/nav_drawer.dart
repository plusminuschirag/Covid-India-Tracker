import 'package:flutter/material.dart';
import '../screen/state_screen.dart';
import '../models/covid_state.dart';

class NavDrawerTile extends StatelessWidget {
  final String stateName;
  final CovidState stateData;

  NavDrawerTile({@required this.stateName, @required this.stateData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: ListTile(
          title: Text(
            stateName,
            style: TextStyle(fontSize: 18),
          ),
          subtitle: Container(
            alignment: FractionalOffset.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  stateData.dayWiseScenerio.last.totalCases.toString(),
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
                  stateData.dayWiseScenerio.last.totalDischarged.toString(),
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
                  stateData.dayWiseScenerio.last.totalDeaths.toString(),
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
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StateScreen(
                        stateName: stateName, stateData: stateData)));
          }),
    );
  }
}
