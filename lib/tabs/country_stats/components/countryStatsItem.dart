import 'package:covid_tracker/util.dart';
import 'package:flutter/material.dart';
import '../../../datasource.dart';

var util = Util();

class CountryStatsItem extends StatelessWidget {
  final List countryData;
  final int index;

  const CountryStatsItem({
    Key? key,
    required this.countryData,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey[100]!,
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
      ),
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
                Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3.5,
                      color: primaryBlack,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Image.network(
                    countryData[index]['countryInfo']['flag'],
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
                    "CONFIRMED: ${util.indianNumberFormat.format(countryData[index]['cases']).toString()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 2.5),
                  child: Text(
                    "ACTIVE: ${util.indianNumberFormat.format(countryData[index]['active']).toString()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 2.5),
                  child: Text(
                    "RECOVERED: ${util.indianNumberFormat.format(countryData[index]['recovered']).toString()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 2.5),
                  child: Text(
                    "DEATHS: ${util.indianNumberFormat.format(countryData[index]['deaths']).toString()}",
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
  }
}
