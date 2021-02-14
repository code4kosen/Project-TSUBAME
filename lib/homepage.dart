import 'package:flutter/material.dart';
import 'package:project_tsubame/widgets/infoList.dart';
import 'package:project_tsubame/widgets/sendInfo.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<Widget> _tab = [
    Tab(child: Text("履歴一覧")),
    Tab(
      child: Text("送信画面"),
    )
  ];

  List<Widget> _tabPages() {
    return [InfoList(), SendInfo()];
  }

  TabController _tabcontroller;

  void initState() {
    super.initState();
    _tabcontroller = TabController(length: _tab.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "TSUBAME-HOME_PAGE",
          ),
        ),
        bottom: TabBar(tabs: _tab, controller: _tabcontroller),
      ),
      body: TabBarView(
        controller: _tabcontroller,
        children: _tabPages(),
      ),
    );
  }
}
