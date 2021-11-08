//import 'dart:html';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lai_hock_chun_mobile_module_final_project/about.dart';
import 'package:lai_hock_chun_mobile_module_final_project/post.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common_component/appbar.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'dart:io';

import 'common_component/serverfile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Log In Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Log In'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void dispose() {
    name.dispose();

    super.dispose();
  }

  TextEditingController name = TextEditingController();
  bool isButtonEnabled = false;

  late bool _isFullyEntered = false;

  @override
  void initState() {
    super.initState();
    streamchannel.listen((message) {
      final decodedMessage = jsonDecode(message);
      final signInResponse = decodedMessage['data']['response'];
      if (signInResponse == "OK") {
        //If it succeed, log in user

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Postpage()),
        );
      } else {
        //channel.sink.close();
        //If it fail, pop up an error
        AlertDialog(
          title: const Text('Sign In Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Sign In Error.'),
                Text('Please try again'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    });
    name.addListener(() {
      _isFullyEntered = _checkFullyEntered(name.text);
      setState(() {});
    });
  }

  bool _checkFullyEntered(String text) {
    if (name.text == '') return false;

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //Text field for name

              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                margin: EdgeInsets.all(16),
                child: TextField(
                  controller: name,
                  maxLines: 1,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Name'),
                ),
              ),

              //Submit Button

              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: name.text != ""
                        ? MaterialStateProperty.all<Color>(Colors.red)
                        : MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () {
                    signIn(name.text);
                    username = name.text;
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

  void signIn(String arguments) {
    channel.sink.add('{"type": "sign_in","data": {"name": "$arguments"}}');
  }
}
