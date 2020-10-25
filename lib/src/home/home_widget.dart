import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:sqliteapp/src/category/category_widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (contex) {
                return CategoryWidget();
              }));
            },
          )
        ],
        title: Text("App with SQLite"),
      ),
      body: Container(),
    );
  }
}
