import 'package:flutter/material.dart';

class Chats extends StatefulWidget {
  @override
  ChatsState createState() => ChatsState();
}

class ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 16),
        alignment: Alignment.center,
        height: 56,
        width: double.infinity,
        color: Colors.lightBlue[50],
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.menu),
                Text(
                  "Umbrella Chat",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.search)
              ],
            ),
          ],
        ),
      )),
    );
  }
}
