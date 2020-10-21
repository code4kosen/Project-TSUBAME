import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  FocusNode nameNode, _bodyFocus;


  @override
  void initState() {
    super.initState();

    // nameNode = FocusNode();
    _bodyFocus = FocusNode();
  }

  @override
  void dispose(){
    nameNode.dispose();
    _bodyFocus.dispose();

    super.dispose();
  }

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
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                validator: (value){
                  if(value.isEmpty){
                    return '名前を入力してください';
                  }
                  return null;
                },
                onFieldSubmitted: (value){
                  FocusScope.of(context).requestFocus(_bodyFocus);
                },
                autofocus: true,
                keyboardType: TextInputType.name,
                decoration:
                    InputDecoration(icon: Icon(Icons.person), hintText: '送信者名'),
              ),

              TextFormField(
                focusNode: _bodyFocus,
              ),

              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: RaisedButton(
                  onPressed:(){
                    if(_formKey.currentState.validate()){
                      _formKey.currentState.save();
                    }
                  },
                  color:Colors.cyan[300],
                  child: Text(
                    "送信",
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
