import 'dart:convert';
import 'package:covid_tracker/tabs/worldwide/components/imageAndText.dart';
import 'package:covid_tracker/tabs/worldwide/components/mostAffectedCountries.dart';
import 'package:covid_tracker/tabs/worldwide/components/worldwidePanel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';

class WorldHomePage extends StatefulWidget {
  @override
  _WorldHomePageState createState() => _WorldHomePageState();
}

class _WorldHomePageState extends State<WorldHomePage> {
  List countryData = [];
  Map worldData = {};
  void fetchAllData() async {
    http.Response worldDataResponse =
        await http.get(Uri.parse("https://disease.sh/v3/covid-19/all"));
    setState(() {
      worldData = json.decode(worldDataResponse.body);
    });

    http.Response countryDeathDataResponse = await http
        .get(Uri.parse("https://disease.sh/v3/covid-19/countries?sort=deaths"));
    setState(() {
      countryData = json.decode(countryDeathDataResponse.body);
    });
  }

  @override
  void initState() {
    fetchAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: countryData.length == 0 && worldData.isEmpty == true
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  ImageAndText(),
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 150),
                        child: WorldwidePanel(worldData: worldData),
                      ),
                      SizedBox(height: 30.0),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          'Pie Chart',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      PieChart(
                        dataMap: {
                          'Active': worldData['active'].toDouble(),
                          'Recovered': worldData['recovered'].toDouble(),
                          'Deaths': worldData['deaths'].toDouble(),
                        },
                        colorList: [
                          Colors.blue[300]!,
                          Colors.green[300]!,
                          Colors.grey[500]!,
                        ],
                        chartValuesOptions: ChartValuesOptions(
                          decimalPlaces: 1,
                          showChartValuesInPercentage: true,
                          chartValueBackgroundColor: Colors.transparent,
                        ),
                      ),
                      SizedBox(height: 50.0),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Most affected Countries',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      countryData.length == 0
                          ? Center(child: CircularProgressIndicator())
                          : MostAffectedPanel(countryData: countryData),
                      SizedBox(height: 25),
                      Text(
                        "Made By Maulik Shah",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 35),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
