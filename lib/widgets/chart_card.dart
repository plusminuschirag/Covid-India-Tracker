import 'package:flutter/material.dart';

class ChartCard extends StatelessWidget {
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
                  leading: Text("🇮🇳", style: TextStyle(fontSize: 30)),
                  title: Text(
                    "COVID-19 India App",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          Card(
            margin: EdgeInsets.all(20),
            elevation: 5,
            child: SizedBox(
              height: 300,
              width: 300,
            ),
          ),
        ],
      ),
    );
  }
}
