import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatefulWidget {
  String body;
  String newsName;
  Timestamp timeStamp;
  String label;

  InfoCard({this.newsName, this.body, this.timeStamp, this.label});

  @override
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
          color: Colors.blue[200],
          border: Border.all(
            color: Colors.black,
            width: 0.5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      padding: EdgeInsets.only(top: 5.0, bottom: 8.0),
      margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 15.0),
      child: Column(
        children: [
          Text("${widget.newsName} [${widget.label}] \n${widget.timeStamp.toDate().toString()}",textAlign: TextAlign.center),
          Divider(),
          Text(widget.body + "\n"),
        ],
      ),
    );
  }
}
