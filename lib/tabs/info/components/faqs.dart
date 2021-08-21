import 'package:flutter/material.dart';
import '../../../datasource.dart';

class FAQs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: DataSource.questionAnswers.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: ExpansionTile(
              title: Text(
                DataSource.questionAnswers[index]['question'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
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
    );
  }
}
