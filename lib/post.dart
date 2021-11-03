import 'package:flutter/material.dart';

class Postpage extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Deriv',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Post"),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text('About'),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Log Out'),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.all(8),
                margin: EdgeInsets.all(1),
                height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(child: Text("About")),
                    Container(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.green)),
                        onPressed: null,
                        child: const Text('Disabled'),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
