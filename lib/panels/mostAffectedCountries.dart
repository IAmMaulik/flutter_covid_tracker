import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var indianNumberFormat = NumberFormat.simpleCurrency(
  locale: "en_IN",
  decimalDigits: 0,
  name: "",
);

class MostAffectedPanel extends StatelessWidget {
  final List countryData;

  const MostAffectedPanel({
    Key? key,
    required this.countryData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.network(
                  countryData[index]['countryInfo']['flag'],
                  height: 50,
                  width: 50,
                ),
                SizedBox(width: 30),
                Text(
                  countryData[index]['country'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
                SizedBox(width: 30),
                Text(
                  'Deaths: ' +
                      indianNumberFormat
                          .format(countryData[index]['deaths'])
                          .toString(),
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          );
        },
        itemCount: 5,
      ),
    );
  }
}
