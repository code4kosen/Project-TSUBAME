import 'package:flutter/material.dart';
import 'package:project_tsubame/widgets/sendInfo.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Center(
          child: Text(
            "TSUBAME-HOME_PAGE",
          ),
        )),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.blueAccent),
                child: Center(
                    child: Text(
                  "Project TSUBAME",
                )))
          ],
        )),
        body: SendInfo());
  }
}
