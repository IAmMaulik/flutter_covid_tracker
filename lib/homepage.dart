import 'dart:convert';
import 'package:covid_tracker/pages/countries.dart';
import 'package:covid_tracker/panels/infoPanel.dart';
import 'package:covid_tracker/panels/mostAffectedCountries.dart';
import 'package:covid_tracker/panels/worldwide.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';
import 'datasource.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData = {
    "cases": "Loading",
    "deaths": "Loading",
    "active": "Loading",
    "recovered": "Loading",
  };
  fetchWorldData() async {
    http.Response response =
        await http.get(Uri.parse("https://disease.sh/v3/covid-19/all"));
    setState(() {
      worldData = jsonDecode(response.body);
    });
  }

  // While data is being fteched from API, it will have some dummy data inside it
  List countryData = List<Map>.generate(
      5,
      (index) => {
            "countryInfo": {
              "flag":
                  "https://png.pngtree.com/png-vector/20200224/ourmid/pngtree-colorful-loading-icon-png-image_2152960.jpg"
            },
            "country": "Loading...",
            "deaths": "Loading...",
          });
  fetchCountryData() async {
    http.Response response = await http
        .get(Uri.parse("https://disease.sh/v3/covid-19/countries?sort=deaths"));
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  Future fetchAllData() async {
    fetchWorldData();
    fetchCountryData();
  }

  @override
  void initState() {
    fetchAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("COVID-19 TRACKER"),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: fetchAllData,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Worldwide",
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CountryPage()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryBlack,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Regional',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                WorldwidePanel(worldData: worldData),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                  ],
                ),
                PieChart(
                  dataMap: {
                    'Active': worldData['recovered'].toDouble(),
                    'Recovered': worldData['active'].toDouble(),
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
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
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
        ),
      ),
    );
  }
}
