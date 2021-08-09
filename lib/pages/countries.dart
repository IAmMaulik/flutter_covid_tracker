import 'package:covid_tracker/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryPage extends StatefulWidget {
  const CountryPage({Key? key}) : super(key: key);

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  // While data is being fteched from API, it will have some dummy data inside it
  List countryData = List<Map>.generate(
      15,
      (index) => {
            "countryInfo": {
              "flag":
                  "https://png.pngtree.com/png-vector/20200224/ourmid/pngtree-colorful-loading-icon-png-image_2152960.jpg"
            },
            "country": "Loading...",
            "deaths": "Loading...",
            "active": "Loading...",
            "recovered": "Loading...",
            "cases": "Loading...",
          });
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
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            height: 130,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey[100]!,
                blurRadius: 10,
                offset: Offset(0, 10),
              ),
            ]),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        countryData[index]['country'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Image.network(
                        countryData[index]['countryInfo']['flag'],
                        height: 70,
                        width: 80,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 2.5),
                        child: Text(
                          "CONFIRMED: ${countryData[index]['cases'].toString()}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 2.5),
                        child: Text(
                          "ACTIVE: ${countryData[index]['active'].toString()}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 2.5),
                        child: Text(
                          "RECOVERED: ${countryData[index]['recovered'].toString()}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 2.5),
                        child: Text(
                          "DEATHS: ${countryData[index]['deaths'].toString()}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        itemCount: countryData.length,
      ),
    );
  }
}
