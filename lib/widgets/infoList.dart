import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_tsubame/widgets/infoCard.dart';

class InfoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InfoListState();
}

class _InfoListState extends State<InfoList> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var collection = db.collection('news').orderBy('Date', descending: true);
    return StreamBuilder<QuerySnapshot>(
      stream: collection.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("エラーが発生しました．");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              body: Center(
                  child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: size.width * 0.1),
                      child: LinearProgressIndicator())));
        }

        return ListView(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            children: snapshot.data.docs.map((dc) {
              return InfoCard(
                newsName: dc.data()['Name'],
                body: dc.data()['Body'].replaceAll("\\n", "\n"),
                timeStamp: dc.data()['Date'],
                label: dc.data()['Label'],
              );
            }).toList());
      },
    );
  }
}
