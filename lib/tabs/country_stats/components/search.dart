import 'package:covid_tracker/tabs/country_stats/components/countryStatsItem.dart';
import 'package:covid_tracker/tabs/country_stats/screens/country.dart';
import 'package:flutter/material.dart';
import '../../../util.dart';

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
          child: CountryStatsItem(
            countryData: suggestionList,
            index: index,
          ),
        );
      },
      itemCount: suggestionList.length,
    );
  }
}
