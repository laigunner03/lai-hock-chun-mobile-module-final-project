import 'package:flutter/material.dart';
import 'common_component/appbar.dart';

class Aboutpage extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'About Page',
      home: Scaffold(
        appBar: AppBar(
          title: Text('About Page'),
        ),
        drawer: appBar(),
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
