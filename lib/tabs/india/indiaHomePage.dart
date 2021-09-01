import 'package:covid_tracker/tabs/india/components/casesPanel.dart';
import 'package:covid_tracker/tabs/india/components/graph.dart';
import 'package:covid_tracker/tabs/india/components/imageAndText.dart';
import 'package:flutter/material.dart';

class IndiaHomePage extends StatefulWidget {
  @override
  _IndiaHomePageState createState() => _IndiaHomePageState();
}

class _IndiaHomePageState extends State<IndiaHomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ImageAndText(),
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 150),
              child: CasesPanel(),
            ),
            Graph(),
          ],
        ),
      ],
    );
  }
}
