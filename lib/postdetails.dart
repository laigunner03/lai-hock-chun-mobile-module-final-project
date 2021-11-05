import 'package:flutter/material.dart';
import 'package:lai_hock_chun_mobile_module_final_project/createpost.dart';
import 'common_component/appbar.dart';

class Postdetailspage extends StatelessWidget {
  final String defaultimage =
      "https://iupac.org/wp-content/uploads/2018/05/default-avatar.png";

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Deriv',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Post Details"),
        ),
        drawer: appBar(),
        body: SafeArea(
            child: Column(
          children: [
            Container(child: Image.network(defaultimage)),
            Container(
              child: Text("Title"),
            ),
            Container(
              child: Text("Details"),
            ),
          ],
        )),
      ),
    );
  }
}
