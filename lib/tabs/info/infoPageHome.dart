import 'package:covid_tracker/tabs/info/components/donate.dart';
import 'package:covid_tracker/tabs/info/components/faqs.dart';
import 'package:covid_tracker/tabs/info/components/mythbusters.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Donate(),
        Mythbusters(),
        FAQs(),
      ],
    );
  }
}
