class CovidDay {
  DateTime date;
  int totalCases;
  int totalDeaths;
  int totalDischarged;

  CovidDay(
      {this.date, this.totalCases, this.totalDeaths, this.totalDischarged});

  CovidDay operator -(CovidDay previousDay) => CovidDay(
        date: date,
        totalCases: totalCases - previousDay.totalCases,
        totalDeaths: totalDeaths - previousDay.totalDeaths,
        totalDischarged: totalDischarged - previousDay.totalDischarged,
      );
}
