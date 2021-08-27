import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IndiaHomePage extends StatefulWidget {
  @override
  _IndiaHomePageState createState() => _IndiaHomePageState();
}

class _IndiaHomePageState extends State<IndiaHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Image.asset("assets/images/covid-wpr.jpg"),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
                child: Text(
                  "India",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  "Last Updated : ${DateFormat('dd/MM/yyyy').format(DateTime.now())}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
