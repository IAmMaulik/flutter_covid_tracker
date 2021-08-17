import 'package:covid_tracker/datasource.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs'),
      ),
      body: ListView.builder(
        itemCount: DataSource.questionAnswers.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
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
          );
        },
      ),
    );
  }
}
