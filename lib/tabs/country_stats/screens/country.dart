import 'dart:convert';
import 'dart:ui';
import 'package:covid_tracker/datasource.dart';
import 'package:covid_tracker/tabs/country_stats/screens/casesPanel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Country extends StatefulWidget {
  final String countryiso3;
  final String flag;
  final String totalCases;
  final String totalRecovered;
  final String totalActive;
  final String totalDeaths;

  const Country({
    Key? key,
    required this.countryiso3,
    required this.flag,
    required this.totalCases,
    required this.totalRecovered,
    required this.totalActive,
    required this.totalDeaths,
  }) : super(key: key);

  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  Map countryData = {};
  fetchCountryData() async {
    http.Response response = await http.get(Uri.parse(
        "https://disease.sh/v3/covid-19/historical/${widget.countryiso3}?lastdays=all"));
    setState(() {
      countryData = json.decode(response.body);
    });
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
      return countryData.length == 0
          ? 0
          : countryData['timeline']['$type'][countryData['timeline']['$type']
                  .keys
                  .elementAt(
                      countryData['timeline']["$type"].keys.length - 1)] -
              countryData['timeline']["$type"][countryData['timeline']['$type']
                  .keys
                  .elementAt(countryData['timeline']['$type'].keys.length - 2)];
    }

    int todayCases = getTodayValues("cases");
    int todayRecovered = getTodayValues("recovered");
    int todayDeaths = getTodayValues("deaths");

    return Scaffold(
      appBar: AppBar(
        title: countryData.length == 0
            ? Text("Loading...")
            : Text(countryData['country']),
        centerTitle: true,
      ),
      body: Center(
        child: countryData.length == 0
            ? Center(child: CircularProgressIndicator())
            : Container(
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
                              countryData['country'],
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
                    CasesPanel(
                      totalCases: widget.totalCases,
                      todayCases: todayCases == 0 ? "" : "$todayCases",
                      totalActive: widget.totalActive,
                      totalRecovered: widget.totalRecovered,
                      todayRecovered:
                          todayRecovered == 0 ? "" : "$todayRecovered",
                      totalDeaths: widget.totalDeaths,
                      todayDeaths: todayDeaths == 0 ? "" : "$todayDeaths",
                    ),
                    SizedBox(height: 50),
                    Text(
                      "GRAPH HERE",
                      style: TextStyle(fontSize: 60),
                      softWrap: true,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
