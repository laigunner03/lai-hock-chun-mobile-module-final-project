import 'package:flutter/material.dart';

class Aboutpage extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Deriv',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello'),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(16),
            child: Text(
              'Hello Deriv',
              style: TextStyle(
                  color: Colors.brown.shade400,
                  fontWeight: FontWeight.bold,
                  fontSize: 60),
            ),
          ),
        ),
      ),
    );
  }
}
