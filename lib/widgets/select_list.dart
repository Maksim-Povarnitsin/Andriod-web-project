import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:chat/widgets/my_chats.dart';

class SelectList extends StatefulWidget {
  @override
  _SelectListState createState() => _SelectListState();
}

TabController tabController;
int selectedIndex = 0;

class _SelectListState extends State<SelectList>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    new Tab(text: 'FIRST'),
    new Tab(text: 'SECOND'),
  ];

  List<Widget> list = [
    Tab(text: "ЧАТЫ"),
    Tab(text: "ГРУППЫ"),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: list.length, vsync: this);

    tabController.addListener(() {
      setState(() {
        selectedIndex = tabController.index;
      });
      print("Selected Index: " + tabController.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50.0,
        color: Colors.white,
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              Container(
                constraints: BoxConstraints.expand(height: 50),
                child: TabBar(
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
                    controller: tabController,
                    onTap: (index) {
                      controller.animateToPage(index,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.linear);
                    }),
              ),
            ],
          ),
        ));
  }
}
