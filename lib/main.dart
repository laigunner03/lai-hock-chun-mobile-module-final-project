import 'package:flutter/material.dart';
import 'package:lai_hock_chun_mobile_module_final_project/about.dart';
import 'package:lai_hock_chun_mobile_module_final_project/post.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common_component/appbar.dart';

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
  TextEditingController name = TextEditingController();

  bool isButtonEnabled = false;

  //Drop-down-value

  @override
  void dispose() {
    name.dispose();

    super.dispose();
  }

  late bool _isFullyEntered = false;

  @override
  void initState() {
    super.initState();

    name.addListener(() {
      _isFullyEntered = _checkFullyEntered(name.text);
      setState(() {});
    });

    autoLogIn();
  }

  bool _checkFullyEntered(String text) {
    if (name.text == '') return false;

    return true;
  }

  late bool isLoggedIn = false;

  late String emaillogin = '';

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? nameId = prefs.getString('name');
    print(nameId);
    if (nameId != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Postpage()));
    }
  }

  // Future<Null> logout() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('email', '');

  //   setState(() {
  //     emaillogin = '';
  //     isLoggedIn = false;
  //   });
  // }

  Future<Null> loginUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', name.text);

    setState(() {
      emaillogin = name.text;
      isLoggedIn = true;
    });

    name.clear();
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
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                margin: EdgeInsets.all(16),
                child: TextField(
                  controller: name,
                  maxLines: 1,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Name'),
                  onSubmitted: (String value) => print(value),
                ),
              ),

              //Email

              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: _isFullyEntered
                        ? MaterialStateProperty.all<Color>(Colors.green)
                        : MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: _isFullyEntered
                      ? () {
                          isLoggedIn ? loginUser() : null;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Postpage()),
                          );
                        }
                      : null,
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
