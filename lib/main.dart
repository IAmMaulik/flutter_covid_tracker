import 'package:covid_tracker/datasource.dart';
import 'package:covid_tracker/tabs/worldwide/worldwideScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Circular",
        primaryColor: primaryBlack,
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
        ),
      ),
      home: WorldHomePage(),
    );
  }
}
