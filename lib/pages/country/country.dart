import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../datasource.dart';

class Country extends StatefulWidget {
  final String countryiso3;
  const Country({Key? key, required this.countryiso3}) : super(key: key);

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
            : Text("${countryData['country']}"),
        centerTitle: true,
      ),
      body: Center(
        child: countryData.length == 0
            ? Center(
                child: CircularProgressIndicator(
                color: primaryBlack,
              ))
            : Container(
                child: Center(
                  child: Text("Data Loaded"),
                ),
              ),
      ),
    );
  }
}
