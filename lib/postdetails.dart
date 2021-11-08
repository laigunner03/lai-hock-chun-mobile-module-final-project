import 'package:flutter/material.dart';
import 'package:lai_hock_chun_mobile_module_final_project/createpost.dart';
import 'common_component/appbar.dart';

class Postdetailspage extends StatelessWidget {
  final String defaultimage =
      "https://iupac.org/wp-content/uploads/2018/05/default-avatar.png";

  const Postdetailspage({
    Key? key,
    required this.title,
    required this.description,
    required this.url,
    required this.name,
  }) : super(key: key);

  final String title;
  final String description;
  final String url;
  final String name;

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Deriv',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Post Details"),
        ),
        drawer: appBar(),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
                child: Image.network(
                    Uri.parse(url).isAbsolute ? url : defaultimage)),
            Container(
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60),
              ),
            ),
            Container(
              child: Text(
                description,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
