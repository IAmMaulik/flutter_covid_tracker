import 'dart:convert';
import 'package:covid_tracker/tabs/worldwide/screens/countryStats.dart';
import 'package:covid_tracker/tabs/worldwide/components/infoPanel.dart';
import 'package:covid_tracker/tabs/worldwide/components/mostAffectedCountries.dart';
import 'package:covid_tracker/tabs/worldwide/components/worldwidePanel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("COVID-19 TRACKER"),
        centerTitle: true,
      ),
      body: countryData.length == 0 && worldData.length == 0
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Worldwide",
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  WorldwidePanel(worldData: worldData),
                  SizedBox(height: 30.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CountryPage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red[500],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Country Wise Data',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
                  MostAffectedPanel(countryData: countryData),
                  SizedBox(height: 25),
                  InfoPanel(),
                  SizedBox(height: 35),
                  Center(
                    child: Text(
                      'TOGETHER, WE WILL WIN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 35)
                ],
              ),
            ),
    );
  }
}
