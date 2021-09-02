import 'package:covid_tracker/tabs/country_stats/screens/country.dart';
import 'package:covid_tracker/tabs/country_stats/components/countryStatsItem.dart';
import 'package:flutter/material.dart';
import '../../util.dart';

var util = Util();

class CountryPage extends StatelessWidget {
  final List countryData;
  const CountryPage({Key? key, required this.countryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return countryData.length == 0
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Country(
                        countryiso3: countryData[index]['countryInfo']['iso3'],
                        flag: countryData[index]['countryInfo']['flag'],
                        totalCases: util.indianNumberFormat
                            .format(countryData[index]['cases']),
                        totalDeaths: util.indianNumberFormat
                            .format(countryData[index]['deaths']),
                        totalRecovered: util.indianNumberFormat
                            .format(countryData[index]['recovered']),
                        totalActive: util.indianNumberFormat
                            .format(countryData[index]['active']),
                      ),
                    ),
                  );
                },
                child: CountryStatsItem(
                  countryData: countryData,
                  index: index,
                ),
              );
            },
            itemCount: countryData.length,
          );
  }
}
