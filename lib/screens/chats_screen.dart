import 'dart:ui';

import 'package:chat/widgets/my_chats.dart';
import 'package:chat/widgets/select_list.dart';

import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {
  @override
  ChatsScreenState createState() => ChatsScreenState();
}

class ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SelectList(),
            MyChats(),
          ],
        ),
      ),
    );
  }
}
