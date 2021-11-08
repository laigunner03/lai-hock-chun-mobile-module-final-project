import 'package:flutter/material.dart';
import 'package:lai_hock_chun_mobile_module_final_project/about.dart';
import 'package:lai_hock_chun_mobile_module_final_project/common_component/serverfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../post.dart';
import 'serverfile.dart';

class appBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: username != ""
          ? ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.pages),
                  title: Text('Post Page'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Postpage()),
                    );
                  },
                ),
                //Direct to about page
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Aboutpage()),
                    );
                  },
                ),
                //Log out and close connection
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Log Out'),
                  onTap: () {
                    channel.sink.close();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                ),
              ],
            )
          : ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),

                //Direct to about page
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Aboutpage()),
                    );
                  },
                ),
                //Log out and close connection
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Log Out'),
                  onTap: () {
                    channel.sink.close();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                ),
              ],
            ),
    );
  }
}
