import 'package:flutter/material.dart';
import 'package:covid_tracker/util.dart';

var util = Util();

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
            count:
                util.indianNumberFormat.format(worldData['cases']).toString(),
            today: util.indianNumberFormat
                .format(worldData['todayCases'])
                .toString(),
          ),
          StatusPanel(
            title: 'ACTIVE',
            panelColor: Colors.blue[100]!,
            textColor: Colors.blue[900]!,
            count:
                util.indianNumberFormat.format(worldData['active']).toString(),
          ),
          StatusPanel(
            title: 'RECOVERED',
            panelColor: Colors.green[100]!,
            textColor: Colors.green,
            count: util.indianNumberFormat
                .format(worldData['recovered'])
                .toString(),
            today: util.indianNumberFormat
                .format(worldData['todayRecovered'])
                .toString(),
          ),
          StatusPanel(
            title: 'DEATHS',
            panelColor: Colors.grey[400]!,
            textColor: Colors.grey[900]!,
            count:
                util.indianNumberFormat.format(worldData['deaths']).toString(),
            today: util.indianNumberFormat
                .format(worldData['todayDeaths'])
                .toString(),
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
  final String today;

  const StatusPanel({
    Key? key,
    required this.panelColor,
    required this.textColor,
    required this.title,
    required this.count,
    this.today = "",
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
        borderRadius: BorderRadius.circular(12.0),
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
          SizedBox(height: 4),
          Text(
            count,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          today == "" || today == "0"
              ? SizedBox()
              : Text(
                  '(+ $today)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
        ],
      ),
    );
  }
}
