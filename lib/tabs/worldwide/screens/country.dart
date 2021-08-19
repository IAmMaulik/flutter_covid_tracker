import 'dart:convert';
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image.network(
                          widget.flag,
                          height: 160,
                          width: 140,
                        ),
                        Text(
                          countryData['country'],
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              "TOTAL CONFIRMED: ${widget.totalCases}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              "TOTAL ACTIVE: ${widget.totalActive}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              "TOTAL ACTIVE: ${widget.totalRecovered}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              "TOTAL DEATHS: ${widget.totalDeaths}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
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
