import 'package:chat/widgets/group_messages.dart';
import 'package:chat/widgets/private_messages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable

class ChatsScreen extends StatefulWidget {
  @override
  ChatsScreenState createState() => ChatsScreenState();
}

class ChatsScreenState extends State<ChatsScreen>
    with SingleTickerProviderStateMixin {
  List<Widget> list = [
    Tab(text: "ЧАТЫ"),
    Tab(text: "ГРУППЫ"),
  ];

  TabController _tabController;
  int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: list.length, vsync: this);

    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
      print("Selected Index: " + _tabController.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              padding: EdgeInsets.only(right: 20, left: 20),
              icon: Icon(Icons.menu),
              iconSize: 24.0,
              color: Color(0xff191E24),
              onPressed: () {},
            ),
            title: Text('Umbrella Chat',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff191E24))),
            elevation: 0.0,
            backgroundColor: Colors.white,
            actions: <Widget>[
              IconButton(
                padding: EdgeInsets.only(right: 20, left: 20),
                icon: Icon(Icons.search),
                iconSize: 24.0,
                color: Color(0xff191E24),
                onPressed: () {},
              )
            ],
            bottom: TabBar(
              controller: _tabController,
              tabs: list,
              labelStyle: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5),
              indicatorColor: Color(0xff3E3E3E),
              indicatorWeight: 3,
              labelColor: Color(0xff191E24),
              unselectedLabelColor: Color(0xff6E7882),
              unselectedLabelStyle: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5),
            )),
        body: TabBarView(
          children: [
            PrivateMessages(),
            GroupMessages(),
          ],
        ),
      ),
    );
  }
}
