import 'package:chat/widgets/group_messages.dart';
import 'package:chat/widgets/private_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:chat/widgets/select_list.dart';

class MyChats extends StatefulWidget {
  @override
  _MyChatsState createState() => _MyChatsState();
}

PageController controller = PageController(
  initialPage: 0,
);

class _MyChatsState extends State<MyChats> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 1000,
      height: MediaQuery.of(context).size.height,
      child: PageView(
        scrollDirection: Axis.horizontal,
        physics: ScrollPhysics(),
        controller: controller,
        onPageChanged: (index) => {
          setState(() {
            tabController.index = index;
          })
        },
        children: <Widget>[
          PrivateMessages(),
          GroupMessages(),
        ],
      ),
    );
  }
}
