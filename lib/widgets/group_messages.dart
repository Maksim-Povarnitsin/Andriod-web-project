import 'package:chat/widgets/private_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GroupMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 15),
        child: conversations(context, groupList));
  }
}

List groupList = [
  {
    "name": "РИС-18-1б",
    "imageUrl":
        'https://i.pinimg.com/564x/20/b3/2e/20b32e3700bc210f2d28e7654956f7d6.jpg',
    "isOnline": false,
    "isReaded": false,
    "message": "Михаил: на что уставлились?",
    "time": "сейчас"
  },
  {
    "name": "Программирование",
    "imageUrl":
        'https://i.pinimg.com/564x/6b/f3/de/6bf3deedf4cc0662e20432d7769f4cac.jpg',
    "isOnline": false,
    "isReaded": true,
    "message": "Вы: деревенские клуши",
    "time": "10м"
  },
  {
    "name": "Пикник",
    "imageUrl":
        'https://i.pinimg.com/564x/d5/83/ab/d583ab9010d6e1a8b5faa8b466182a44.jpg',
    "isOnline": false,
    "isReaded": true,
    "message": "Анна: где я ",
    "time": "1н"
  },
  {
    "name": "РИС-18-1б",
    "imageUrl":
        'https://i.pinimg.com/564x/20/b3/2e/20b32e3700bc210f2d28e7654956f7d6.jpg',
    "isOnline": false,
    "isReaded": false,
    "message": "Михаил: на что уставлились?",
    "time": "сейчас"
  },
  {
    "name": "Программирование",
    "imageUrl":
        'https://i.pinimg.com/564x/6b/f3/de/6bf3deedf4cc0662e20432d7769f4cac.jpg',
    "isOnline": false,
    "isReaded": true,
    "message": "Вы: деревенские клуши",
    "time": "10м"
  },
  {
    "name": "Пикник",
    "imageUrl":
        'https://i.pinimg.com/564x/d5/83/ab/d583ab9010d6e1a8b5faa8b466182a44.jpg',
    "isOnline": false,
    "isReaded": true,
    "message": "Анна: где я ",
    "time": "1н"
  },
  {
    "name": "РИС-18-1б",
    "imageUrl":
        'https://i.pinimg.com/564x/20/b3/2e/20b32e3700bc210f2d28e7654956f7d6.jpg',
    "isOnline": false,
    "isReaded": false,
    "message": "Михаил: на что уставлились?",
    "time": "сейчас"
  },
  {
    "name": "Программирование",
    "imageUrl":
        'https://i.pinimg.com/564x/6b/f3/de/6bf3deedf4cc0662e20432d7769f4cac.jpg',
    "isOnline": false,
    "isReaded": true,
    "message": "Вы: деревенские клуши",
    "time": "10м"
  },
  {
    "name": "Пикник",
    "imageUrl":
        'https://i.pinimg.com/564x/d5/83/ab/d583ab9010d6e1a8b5faa8b466182a44.jpg',
    "isOnline": false,
    "isReaded": true,
    "message": "Анна: где я ",
    "time": "1н"
  },
  {
    "name": "РИС-18-1б",
    "imageUrl":
        'https://i.pinimg.com/564x/20/b3/2e/20b32e3700bc210f2d28e7654956f7d6.jpg',
    "isOnline": false,
    "isReaded": false,
    "message": "Михаил: на что уставлились?",
    "time": "сейчас"
  }
];
