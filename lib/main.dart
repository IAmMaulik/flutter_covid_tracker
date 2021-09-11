import 'dart:convert';
import 'package:covid_tracker/datasource.dart';
import 'package:covid_tracker/tabs/country_stats/components/search.dart';
import 'package:covid_tracker/tabs/country_stats/countryStats.dart';
import 'package:covid_tracker/tabs/info/infoPageHome.dart';
import 'package:covid_tracker/tabs/states/stateScreen.dart';
import 'package:covid_tracker/tabs/worldwide/worldwideScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: "Circular",
      primaryColor: primaryBlack,
      appBarTheme: AppBarTheme(
        brightness: Brightness.dark,
      ),
    ),
    title: "COVID-19 Tracker by Maulik Shah",
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List countryData = [];
  Future fetchData() async {
    http.Response response =
        await http.get(Uri.parse("https://disease.sh/v3/covid-19/countries"));
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  // Used for the Botton Navigation Bar
  int _selectedIndex = 0;
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Lists for the bottom navigation bar
    List<Widget> _widgetList = [
      WorldHomePage(),
      CountryPage(countryData: countryData),
      StateScreen(),
      InfoPage()
    ];
    List<String> _appBarNames = [
      "Worldwide",
      "Country Stats",
      "India",
      "INFORMATION (from WHO)"
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarNames[_selectedIndex]),
        centerTitle: true,
        actions: _appBarNames[_selectedIndex] == "Country Stats"
            ? <Widget>[
                IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: Search(countryData));
                  },
                  icon: Icon(Icons.search),
                ),
              ]
            : [],
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: IndexedStack(
          index: _selectedIndex,
          children: _widgetList,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: "World",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: "Countries",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apartment),
            label: "India",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: "FAQ",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
