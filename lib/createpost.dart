import 'package:flutter/material.dart';
import 'package:lai_hock_chun_mobile_module_final_project/about.dart';
import 'package:lai_hock_chun_mobile_module_final_project/post.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common_component/appbar.dart';

class Createpostpage extends StatelessWidget {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController imageURL = TextEditingController();
  bool isButtonEnabled = false;

  //Drop-down-value

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    imageURL.dispose();
  }

  // late bool _isFullyEntered = false;

  // bool _checkFullyEntered(String text) {
  //   if (title.text == '') return false;
  //   if (description.text == '') return false;
  //   if (imageURL.text == '') return false;

  //   return true;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
      ),
      drawer: appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                margin: EdgeInsets.all(16),
                child: TextField(
                  controller: title,
                  maxLines: 1,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Name'),
                  onSubmitted: (String value) => print(value),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                margin: EdgeInsets.all(16),
                child: TextField(
                  controller: description,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Description'),
                  onSubmitted: (String value) => print(value),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                margin: EdgeInsets.all(16),
                child: TextField(
                  controller: imageURL,
                  maxLines: 1,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'ImageURL'),
                  onSubmitted: (String value) => print(value),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Postpage()),
                    );
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
