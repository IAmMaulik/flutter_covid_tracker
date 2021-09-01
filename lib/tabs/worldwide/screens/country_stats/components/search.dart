import 'package:covid_tracker/tabs/worldwide/screens/country/country.dart';
import 'package:flutter/material.dart';
import '../../../../../datasource.dart';
import '../../../../../util.dart';

var util = Util();

class Search extends SearchDelegate {
  final List countryList;

  Search(this.countryList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? countryList
        : countryList
            .where((element) =>
                element['country'].toString().toLowerCase().startsWith(query))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Country(
                  countryiso3: suggestionList[index]['countryInfo']['iso3'],
                  flag: suggestionList[index]['countryInfo']['flag'],
                  totalCases: util.indianNumberFormat
                      .format(suggestionList[index]['cases']),
                  totalDeaths: util.indianNumberFormat
                      .format(suggestionList[index]['deaths']),
                  totalRecovered: util.indianNumberFormat
                      .format(suggestionList[index]['recovered']),
                  totalActive: util.indianNumberFormat
                      .format(suggestionList[index]['active']),
                ),
              ),
            );
          },
          child: Container(
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
                        suggestionList[index]['country'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5,
                            color: primaryBlack,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Image.network(
                          suggestionList[index]['countryInfo']['flag'],
                          width: MediaQuery.of(context).size.width / 4.5,
                        ),
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
                          "CONFIRMED: ${util.indianNumberFormat.format(suggestionList[index]['cases']).toString()}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 2.5),
                        child: Text(
                          "ACTIVE: ${util.indianNumberFormat.format(suggestionList[index]['active']).toString()}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 2.5),
                        child: Text(
                          "RECOVERED: ${util.indianNumberFormat.format(suggestionList[index]['recovered']).toString()}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 2.5),
                        child: Text(
                          "DEATHS: ${util.indianNumberFormat.format(suggestionList[index]['deaths']).toString()}",
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
          ),
        );
      },
      itemCount: suggestionList.length,
    );
  }
}
