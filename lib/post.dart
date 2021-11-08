import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lai_hock_chun_mobile_module_final_project/common_component/serverfile.dart';
import 'package:lai_hock_chun_mobile_module_final_project/createpost.dart';
import 'package:lai_hock_chun_mobile_module_final_project/postdetails.dart';
import 'common_component/appbar.dart';

//State issue: Post won't show unless hot reload

class Postpage extends StatefulWidget {
  @override
  _Postpagestate createState() => _Postpagestate();
}

class _Postpagestate extends State<Postpage> {
  List data = [];

  int postLimit = 5;

  late Timer timer;

  // late var username = Postpage.name;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => callPost());
  }

  void callPost() {
    setState(() {
      channel.sink.add(
          '{"type": "get_posts", "data": {"lastId": "" , "limit": $postLimit}}');
      streamchannel.listen((message) {
        final decodedMessage = jsonDecode(message);
        data = decodedMessage['data']['posts'];
      });
    });
  }

  late final String defaultimage =
      "https://iupac.org/wp-content/uploads/2018/05/default-avatar.png";

  late String dropdownValue = "A-Z";

  bool isLiked = false;

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Post"),
        ),
        drawer: appBar(),
        body: SafeArea(
            child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.format_align_right_rounded),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;

                    //Sorting method
                    // if (dropdownValue == 'A-Z') {
                    //               setState(() {
                    //                 sort(
                    //                     (a, b) => a.title.compareTo(b.title));
                    //               });
                  });
                },
                items: <String>['A-Z', 'Z-A', 'Favourite']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Postdetailspage([index])),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: EdgeInsets.all(1),
                      height: 140,
                      decoration: BoxDecoration(color: Colors.amberAccent[100]),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,

                        children: [
                          Container(
                              child: Image.network(data[index]['image'],
                                  height: 140, width: 140, fit: BoxFit.fill)),
                          SizedBox(width: 20),
                          Container(
                            width: 140,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    child: Text(
                                  data[index]['title'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                )),
                                Container(
                                    child: Text(data[index]['description'],
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis)),
                                Container(
                                    child: Text(
                                  data[index]['author'],
                                )),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Container(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  //Like
                                  Container(
                                    child: FloatingActionButton(
                                      onPressed: () {},
                                      child: const Icon(
                                          Icons.thumb_up_alt_outlined),
                                      backgroundColor: Colors.green,
                                    ),
                                  ),

                                  SizedBox(width: 10),

                                  //Delete
                                  Container(
                                    child: FloatingActionButton(
                                      onPressed: () {},
                                      child: const Icon(Icons.delete),
                                      backgroundColor: Colors.green,
                                    ),
                                  ),
                                ]),
                          )
                          //SizedBox(height: 120),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => Createpostpage()),
            // );
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
