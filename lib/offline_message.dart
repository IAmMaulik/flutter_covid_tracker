import 'package:flutter/material.dart';

class OfflineMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Center(
        child: Text(
          "You are offline. Connect to a Wi-Fi or Cellular Network to access the app",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
