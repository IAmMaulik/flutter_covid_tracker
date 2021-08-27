import 'package:covid_tracker/tabs/india/components/imageAndText.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IndiaHomePage extends StatefulWidget {
  @override
  _IndiaHomePageState createState() => _IndiaHomePageState();
}

class _IndiaHomePageState extends State<IndiaHomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ImageAndText(),
      ],
    );
  }
}
