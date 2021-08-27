import 'package:covid_tracker/datasource.dart';
import 'package:covid_tracker/tabs/india/indiaHomePage.dart';
import 'package:covid_tracker/tabs/info/infoPageHome.dart';
import 'package:covid_tracker/tabs/states/stateScreen.dart';
import 'package:covid_tracker/tabs/worldwide/worldwideScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Used for the Botton Navigation Bar
  int _selectedIndex = 0;
  List<Widget> _widgetList = [
    IndiaHomePage(),
    StateScreen(),
    WorldHomePage(),
    InfoPage()
  ];
  List<String> _appBarNames = [
    "INDIA",
    "STATES",
    "WORLDWIDE",
    "INFORMATION (from WHO)"
  ];
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      home: Scaffold(
        appBar: AppBar(
          title: Text(_appBarNames[_selectedIndex]),
          centerTitle: true,
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _widgetList,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.flag),
              label: "India",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.apartment),
              label: "States",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.public),
              label: "World",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.question_answer),
              label: "FAQ",
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
        ),
      ),
    );
  }
}
