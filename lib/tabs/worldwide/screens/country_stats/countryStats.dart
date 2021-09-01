import 'package:covid_tracker/tabs/worldwide/screens/country/country.dart';
import 'package:covid_tracker/tabs/worldwide/screens/country_stats/components/countryStatsItem.dart';
import 'package:covid_tracker/tabs/worldwide/screens/country_stats/components/search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../util.dart';

var util = Util();

class CountryPage extends StatefulWidget {
  const CountryPage({Key? key}) : super(key: key);

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List countryData = [];
  fetchCountryData() async {
    http.Response response =
        await http.get(Uri.parse("https://disease.sh/v3/covid-19/countries"));
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
          centerTitle: true,
          title: Text("Country Stats"),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Search(countryData));
              },
              icon: Icon(Icons.search),
            ),
          ]),
      body: countryData.length == 0
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Country(
                          countryiso3: countryData[index]['countryInfo']
                              ['iso3'],
                          flag: countryData[index]['countryInfo']['flag'],
                          totalCases: util.indianNumberFormat
                              .format(countryData[index]['cases']),
                          totalDeaths: util.indianNumberFormat
                              .format(countryData[index]['deaths']),
                          totalRecovered: util.indianNumberFormat
                              .format(countryData[index]['recovered']),
                          totalActive: util.indianNumberFormat
                              .format(countryData[index]['active']),
                        ),
                      ),
                    );
                  },
                  child: CountryStatsItem(
                    countryData: countryData,
                    index: index,
                  ),
                );
              },
              itemCount: countryData.length,
            ),
    );
  }
}
