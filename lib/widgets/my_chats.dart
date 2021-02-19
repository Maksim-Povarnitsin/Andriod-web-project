import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:chat/widgets/selecting_list.dart';

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
      height: 1000,
      // height: MediaQuery.of(context).size.height,
      child: PageView(
        scrollDirection: Axis.horizontal,
        //physics: BouncingScrollPhysics(),
        controller: controller,
        onPageChanged: (number) {
          print("$number");
          setState(() {
            selectedIndex = number;
          });
        },
        children: <Widget>[
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
