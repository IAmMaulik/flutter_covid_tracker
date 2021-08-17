import 'package:covid_tracker/datasource.dart';
import 'package:covid_tracker/homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void fetchAllData() async {
    Map worldData = {};
    http.Response worldDataResponse =
        await http.get(Uri.parse("https://disease.sh/v3/covid-19/all"));
    worldData = jsonDecode(worldDataResponse.body);

    List countryData = [];
    http.Response countryDeathDataResponse = await http
        .get(Uri.parse("https://disease.sh/v3/covid-19/countries?sort=deaths"));
    countryData = json.decode(countryDeathDataResponse.body);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          worldData: worldData,
          countryData: countryData,
        ),
      ),
    );
  }

  @override
  void initState() {
    fetchAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: primaryBlack),
      child: Center(
        child: SpinKitRing(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
