import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var indianNumberFormat = NumberFormat.simpleCurrency(
  locale: "en_IN",
  decimalDigits: 0,
  name: "",
);

class WorldwidePanel extends StatelessWidget {
  final Map worldData;

  const WorldwidePanel({
    Key? key,
    required this.worldData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
        ),
        children: <Widget>[
          StatusPanel(
            title: 'CONFIRMED',
            panelColor: Colors.red[100]!,
            textColor: Colors.red,
            count: indianNumberFormat.format(worldData['cases']).toString(),
          ),
          StatusPanel(
            title: 'ACTIVE',
            panelColor: Colors.blue[100]!,
            textColor: Colors.blue[900]!,
            count: indianNumberFormat.format(worldData['active']).toString(),
          ),
          StatusPanel(
            title: 'RECOVERED',
            panelColor: Colors.green[100]!,
            textColor: Colors.green,
            count: indianNumberFormat.format(worldData['recovered']).toString(),
          ),
          StatusPanel(
            title: 'DEATHS',
            panelColor: Colors.grey[400]!,
            textColor: Colors.grey[900]!,
            count: indianNumberFormat.format(worldData['deaths']).toString(),
          ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanel({
    Key? key,
    required this.panelColor,
    required this.textColor,
    required this.title,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(10),
      height: 80,
      width: width / 2,
      decoration: BoxDecoration(
        color: panelColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor,
            ),
          ),
          Text(
            count,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          )
        ],
      ),
    );
  }
}
