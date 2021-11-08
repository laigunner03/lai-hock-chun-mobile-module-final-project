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
  List data = []; //initialized data to be called

  int postLimit = 20;

  late Timer timer;

  // late var username = Postpage.name;

  @override
  void initState() {
    super.initState();
    callPost();
    timer =
        Timer.periodic(Duration(milliseconds: 500), (Timer t) => callPost());
  }

  @override
  void dispose() {
    super.dispose();
  }

  void callPost() {
    channel.sink.add(
        '{"type": "get_posts", "data": {"lastId": "" , "limit": $postLimit}}');
    streamchannel.listen((message) {
      final decodedMessage = jsonDecode(message);
      data = decodedMessage['data']['posts'];
    });
    setState(() {});
  }

  void deletePost() {
    streamchannel.listen((message) {
      final decodedMessage = jsonDecode(message);
      final deleteData = decodedMessage['type'];
      print("$deleteData");
    });
  }

  late final String defaultimage =
      "https://iupac.org/wp-content/uploads/2018/05/default-avatar.png";

  late String dropdownValue = "A-Z";

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
            //Drop down button but not working
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
                    if (dropdownValue == 'A-Z') {
                      setState(() {
                        data.sort((a, b) => a.title.compareTo(b.title));
                      });
                    }
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

            //List view
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Postdetailspage(
                                url: data[index]['image'],
                                title: data[index]['title'],
                                description: data[index]['description'],
                                name: data[index]['author'])),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: EdgeInsets.all(1),
                      height: 140,
                      decoration: BoxDecoration(color: Colors.amberAccent[100]),
                      child: Row(
                        //Images, if is not valid, show default image
                        children: [
                          Container(
                              child: Image.network(
                                  Uri.parse(data[index]['image']).isAbsolute &&
                                          data[index].containsKey('image')
                                      ? data[index]['image']
                                      : defaultimage,
                                  height: 140,
                                  width: 140,
                                  fit: BoxFit.fill)),
                          SizedBox(width: 20),
                          Container(
                            width: 140,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                //Tittle
                                Container(
                                    child: Text(
                                  data[index]['title'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                )),

                                //Description
                                Container(
                                    child: Text(data[index]['description'],
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis)),
                                //Author
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
                                  //Like button

                                  Container(
                                    child: FloatingActionButton(
                                      onPressed: () {
                                        // if (isLiked[index] == false) {
                                        //   isLiked[index] = true;
                                        // } else
                                        //   isLiked[index] = false;
                                      },
                                      child: Icon(Icons.thumb_up_alt_outlined),
                                      backgroundColor: Colors.green,
                                    ),
                                  ),

                                  SizedBox(width: 10),

                                  //Delete
                                  Container(
                                    child: FloatingActionButton(
                                      onPressed: () {
                                        if (data[index]['author'] == username) {
                                          var deleteID = data[index]["_id"];
                                          print(deleteID);
                                          channel.sink.add(
                                              '{"type": "delete_post","data": {"postId": $deleteID}}');
                                          deletePost();
                                          setState(() {});
                                        }
                                      },
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Createpostpage()),
            );
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
