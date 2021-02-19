import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:chat/widgets/private_messages.dart';

class GroupMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 15), child: conversations(context));
  }
}
