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
  Map worldData = {};
  void fetchWorldData() async {
    http.Response response =
        await http.get(Uri.parse("https://disease.sh/v3/covid-19/all"));
    worldData = jsonDecode(response.body);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(worldData: worldData),
      ),
    );
  }

  @override
  void initState() {
    fetchWorldData();
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
