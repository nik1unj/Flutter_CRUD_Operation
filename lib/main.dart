import 'package:Learn_flutter/Database.dart';
import 'package:flutter/material.dart';

//import 'dart:async';
//import 'package:form_field_validator/form_field_validator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.red), home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbinstance = DBProvider.instance;

  void insertData() async {
    Map<String, dynamic> row = {
      DBProvider.columnName: "Keyur",
      DBProvider.columnage: 18
    };
    final id = await dbinstance.insert(row);
    print(id);
  }

  void queryall() async {
    var allrows = await dbinstance.queryall();
    allrows.forEach((element) {
      print(element);
    });
  }

  void queryspecific() async {
    var allrows = await dbinstance.queryBasic(18);
    print(allrows);
  }

  void delete() async {
    var res = await dbinstance.delete(3);
    print(res);
  }

  void update() async {
    var row = await dbinstance.update(2);
    print(row);
  }

  @override
  Widget build(BuildContext context) {
    //  update();
    return Scaffold(
      appBar: AppBar(
        title: Text("AppBar"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: OutlinedButton(
              onPressed: insertData,
              child: Text("Insert"),
            ),
          ),
          RaisedButton(
            focusElevation: 30.0,
            onPressed: queryall,
            child: Text("FetchAll"),
          ),
          RaisedButton(
            onPressed: queryspecific,
            child: Text("Fetch"),
          ),
          RaisedButton(
            onPressed: delete,
            child: Text("Delete"),
          ),
          RaisedButton(
            onPressed: update,
            child: Text("Update"),
          ),
        ],
      ),
    );
  }
}
