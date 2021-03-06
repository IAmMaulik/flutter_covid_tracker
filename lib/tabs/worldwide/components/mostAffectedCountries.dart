import 'package:flutter/material.dart';
import '../../../datasource.dart';
import '../../../util.dart';

var util = Util();

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
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3.5,
                      color: primaryBlack,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Image.network(
                    countryData[index]['countryInfo']['flag'],
                    width: 70,
                  ),
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
                      util.indianNumberFormat
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
