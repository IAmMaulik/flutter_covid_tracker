import 'package:covid_tracker/pages/countries.dart';
import 'package:covid_tracker/panels/infoPanel.dart';
import 'package:covid_tracker/panels/mostAffectedCountries.dart';
import 'package:covid_tracker/panels/worldwide.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import '../datasource.dart';
// import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  final Map worldData;
  final List countryData;
  const HomePage({
    Key? key,
    required this.worldData,
    required this.countryData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("COVID-19 TRACKER"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CountryPage()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryBlack,
                    borderRadius: BorderRadius.circular(15),
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
      ),
    );
  }
}
