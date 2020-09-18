import 'package:flutter/material.dart';

class NavDrawerTile extends StatelessWidget {
  final String uniqueStateName;

  NavDrawerTile(this.uniqueStateName);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ListTile(
        leading: Icon(Icons.alarm),
        title: Text(
          uniqueStateName,
          style: TextStyle(fontSize: 20),
        ),
        onTap: null,
      ),
    );
  }
}
