import 'package:flutter/material.dart';
import 'package:hh_flutter_refresh/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      title: "Refresh Demo",
      home: HomeWidget(),
    );
  }
}