import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lai_hock_chun_mobile_module_final_project/about.dart';
import 'package:lai_hock_chun_mobile_module_final_project/common_component/serverfile.dart';
import 'package:lai_hock_chun_mobile_module_final_project/post.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common_component/appbar.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'dart:io';
import 'common_component/serverfile.dart';

class Createpostpage extends StatefulWidget {
  @override
  _Createpostpagestate createState() => _Createpostpagestate();
}

class _Createpostpagestate extends State<Createpostpage> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController imageURL = TextEditingController();

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    imageURL.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  //final channel = IOWebSocketChannel.connect('ws://besquare-demo.herokuapp.com');

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
                  //onSubmitted: (String value) => print(value),
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
                  //onSubmitted: (String value) => print(value),
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
                  //onSubmitted: (String value) => print(value),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                  onPressed: () {
                    createPost(title.text, description.text, imageURL.text);
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

  void createPost(titleP, descriptionP, imageP) {
    channel.sink.add(
        '{"type": "create_post", "data": {"title": "$titleP","description": "$descriptionP" ,"image": "$imageP" }}');
    print("$titleP $descriptionP $imageP");

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Post successfully created!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text(
                      'Post created successfully! You will be redirected to the post page after dismissing this message '),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Postpage()),
                  );
                },
              ),
            ],
          );
        });
  }
}
