import 'covid_day.dart';

class CovidState {
  String stateName;
  List<CovidDay> dayWiseScenerio;

  CovidState() {
    stateName = 'No Name';
    dayWiseScenerio = [];
  }

  CovidState.params(this.stateName, this.dayWiseScenerio);

  set setStateName(String givenStateName) => stateName = givenStateName;

  set setDayWiseScenerio(List<CovidDay> givenDayWiseScenerio) =>
      dayWiseScenerio = givenDayWiseScenerio;
}
