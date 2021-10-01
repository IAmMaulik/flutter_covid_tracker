import 'dart:convert';
import 'package:covid_tracker/datasource.dart';
import 'package:covid_tracker/tabs/country_stats/screens/casesPanel.dart';
import 'package:covid_tracker/tabs/country_stats/screens/graph.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Country extends StatefulWidget {
  final String countryiso3;
  final String flag;
  final String totalCases;
  final String totalRecovered;
  final String totalActive;
  final String totalDeaths;
  final String countryName;

  const Country({
    Key? key,
    required this.countryiso3,
    required this.flag,
    required this.totalCases,
    required this.totalRecovered,
    required this.totalActive,
    required this.totalDeaths,
    required this.countryName,
  }) : super(key: key);

  @override
  _CountryState createState() => _CountryState();
}

int todayCases = 0;
int todayRecovered = 0;
int todayDeaths = 0;

class _CountryState extends State<Country> {
  Map countryData = {};
  Future fetchCountryData() async {
    if (widget.countryiso3 != "") {
      http.Response response = await http.get(Uri.parse(
          "https://disease.sh/v3/covid-19/historical/${widget.countryiso3}?lastdays=all"));
      setState(() {
        countryData = json.decode(response.body);
      });
    } else {
      setState(() {
        countryData = {"isNotAvailable": true};
      });
    }
  }

  @override
  void initState() {
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getTodayValues(String type) {
      // Takes today's values and subtracts yesterday' values to get daily cases
      if (countryData.length == 0 || countryData['message'] != null) {
        return 0;
      } else {
        int todayTotalCases = countryData['timeline']['$type'][
            countryData['timeline']['$type']
                .keys
                .elementAt(countryData['timeline']["$type"].keys.length - 1)];
        int yesterdayTotalCases = countryData['timeline']["$type"][
            countryData['timeline']['$type']
                .keys
                .elementAt(countryData['timeline']['$type'].keys.length - 2)];
        return todayTotalCases - yesterdayTotalCases;
      }
    }

    if (countryData.length != 0 && widget.countryiso3 != "") {
      todayCases = getTodayValues("cases");
      todayRecovered = getTodayValues("recovered");
      todayDeaths = getTodayValues("deaths");
    }

    return Scaffold(
      appBar: AppBar(
        title: countryData.length == 0
            ? Text("Loading...")
            : Text(widget.countryName),
        centerTitle: true,
      ),
      body: countryData.length == 0
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: fetchCountryData,
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 5,
                                  color: primaryBlack,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Image.network(widget.flag),
                              width: MediaQuery.of(context).size.width / 3,
                            ),
                            Container(
                              child: Text(
                                widget.countryName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap: true,
                              ),
                              width: MediaQuery.of(context).size.width / 2,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CasesPanel(
                          totalCases: widget.totalCases,
                          todayCases: todayCases == 0
                              ? ""
                              : util.indianNumberFormat.format(todayCases),
                          totalActive: widget.totalActive,
                          totalRecovered: widget.totalRecovered,
                          todayRecovered: todayRecovered == 0
                              ? ""
                              : util.indianNumberFormat.format(todayRecovered),
                          totalDeaths: widget.totalDeaths,
                          todayDeaths: todayDeaths == 0
                              ? ""
                              : util.indianNumberFormat.format(todayDeaths),
                        ),
                      ),
                      SizedBox(height: 50),
                      countryData['message'] != null ||
                              countryData['isNotAvailable'] == true
                          ? Text(
                              "Graph Not Available",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 50),
                              softWrap: true,
                            )
                          : Graph(data: countryData),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
