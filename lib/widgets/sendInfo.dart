import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SendInfo extends StatefulWidget {
  @override
  State<SendInfo> createState() => _SendInfoState();
}

class _SendInfoState extends State<SendInfo> {
  final db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  String _name;
  String _body;

  FocusNode nameNode, _bodyFocus;

  List<String> labels = <String>[
    "防災情報",
    "火災情報",
    "計画停電情報",
    "防犯情報",
    "その他",
    "行方不明者",
    "不審者情報"
  ];

  String selectLabel = "防災情報";

  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _bodyFocus = FocusNode();
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Flexible(
                flex: 3,
                child: TextFormField(
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
                  decoration: InputDecoration(
                      icon: Icon(Icons.person), hintText: '送信者名'),
                ),
              ),
              Flexible(
                  flex: 1,
                  child: DropdownButton<String>(
                      onChanged: (String newValue) {
                        setState(() {
                          selectLabel = newValue;
                        });
                      },
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      value: selectLabel,
                      items:
                          labels.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList()))
            ]),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 5,
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

  _showToast(bool jd) {
    var text;
    var toastColor;
    var toastIcon;
    if (jd) {
      text = "送信しました．";
      toastColor = Colors.greenAccent;
      toastIcon = Icons.check;
    } else {
      text = "送信に失敗しました．";
      toastColor = Color.fromRGBO(240, 96, 96, 0.4);
      toastIcon = Icons.info;
    }
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: toastColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(toastIcon),
          SizedBox(
            width: 12.0,
          ),
          Text(text),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 3),
    );
  }

  Future<void> addInfo({String name, String body}) async {
    db
        .collection('news')
        .add({
          'Name': _name,
          'Body': _body.replaceAll("\n", "\\n"),
          'Date': DateTime.now().toUtc(),
          'Label': selectLabel
        })
        .then((value) => _showToast(true))
        .catchError((error) => _showToast(false));
  }

  void dispose() {
    nameNode.dispose();
    _bodyFocus.dispose();
    super.dispose();
  }
}
