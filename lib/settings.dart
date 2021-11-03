import 'package:flutter/material.dart';

class Settingpage extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Deriv',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello'),
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
