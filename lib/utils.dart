import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

Map<String, String> problemStateNames = {
  'Telangana***': 'Telangana',
  'Jharkhand#': 'Jharkhand',
  'Nagaland#': 'Nagaland',
  'Madhya Pradesh#': 'Madhya Pradesh',
  'Dadar Nagar Haveli': 'Dadra and Nagar Haveli and Daman and Diu'
};

//Loads Hardcoded Indian Json
Future<String> loadIndiaJson() async {
  return await rootBundle.loadString("assets/covid_19_national.json");
}

//Loads Indian States Data from Json
Future<String> loadStateData() async {
  final String url = 'https://api.rootnet.in/covid19-in/stats/history';
  final response = await http.get(url);
  return response.body;
}

//Fixes State Names
List<String> giveUniqueStateNames(List<dynamic> covidStateData) {
  //Receives whole Json Data

  Set stateNames = new Set();

  covidStateData.forEach((day) {
    (day['regional'] as List).forEach((state) {
      stateNames.add(state['loc']);
    });
  });

  List<String> newStateNames = new List();

  stateNames.toList().forEach((state) {
    if (problemStateNames.containsKey(state)) {
      newStateNames.add(problemStateNames[state]);
    } else {
      newStateNames.add(state);
    }
  });
  return newStateNames.toSet().toList();
}

String fixStateName(String stateNameToFix) {
  if (problemStateNames.containsKey(stateNameToFix)) {
    return problemStateNames[stateNameToFix];
  } else {
    return stateNameToFix;
  }
}
