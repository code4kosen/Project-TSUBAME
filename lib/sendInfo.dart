import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SendInfo extends StatefulWidget {
  @override
  State<SendInfo> createState() => _SendInfoState();
}

class _SendInfoState extends State<SendInfo> {

  final db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  String _name;
  String _body;
  var app;

  FocusNode nameNode, _bodyFocus;

  @override
  void initState() {
    app = Firebase.initializeApp();
    super.initState();
    _bodyFocus = FocusNode();
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return '名前を入力してください';
                }
                return null;
              },
              onSaved: (value) {
                _name = value;
              },
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_bodyFocus);
              },
              autofocus: true,
              keyboardType: TextInputType.name,
              decoration:
                  InputDecoration(icon: Icon(Icons.person), hintText: '送信者名'),
            ),
            TextFormField(
              focusNode: _bodyFocus,
              onSaved: (value) {
                _body = value;
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      addInfo(name: _name, body: _body);
                    }
                  },
                  color: Colors.cyan[300],
                  child: Text(
                    "送信",
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<void> addInfo({String name, String body}) async {
    db.collection('news')
        .add({'Name': _name, 'Body': _body, 'Date': DateTime.now().toUtc()})
        .then((value) => print("news Added"))
        .catchError((error) => print("Failed to add news: %error"));
  }

  void dispose() {
    nameNode.dispose();
    _bodyFocus.dispose();

    super.dispose();
  }
}
