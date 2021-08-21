import 'package:covid_tracker/datasource.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            launch('https://covid19responsefund.org/');
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              color: primaryBlack,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'DONATE   (to WHO)  💰',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  softWrap: true,
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            launch(
                'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/myth-busters');
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              color: primaryBlack,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'MYTH BUSTERS   (from WHO)  🤯',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  softWrap: true,
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: DataSource.questionAnswers.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                child: ExpansionTile(
                  title: Text(
                    DataSource.questionAnswers[index]['question'],
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 25.0,
                      ),
                      child: Text(
                        DataSource.questionAnswers[index]['answer'],
                        style: TextStyle(fontSize: 16.0),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
