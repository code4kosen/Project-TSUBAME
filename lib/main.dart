import 'package:flutter/material.dart';
import 'package:project_tsubame/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Project TSUBAME",
      home: HomePage(),
    );
  }
}

