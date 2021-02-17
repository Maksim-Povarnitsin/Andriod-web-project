import 'dart:ui';

import 'package:flutter/material.dart';

class Chats extends StatefulWidget {
  @override
  Andrew createState() => Andrew();
}

class Andrew extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    final appBar = Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 16),
      alignment: Alignment.center,
      height: 56,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(icon: Icon(Icons.menu), onPressed: null),
          Text(
            "Umbrella Chat",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          IconButton(icon: Icon(Icons.search), onPressed: null),
        ],
      ),
    );

    final Chats_Groups = Container(
      //padding: EdgeInsets.only(left: 20, right: 20, top: 16),
      alignment: Alignment.center,
      height: 56,
      width: double.infinity,
      //color: Colors.lightBlue[50],
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ButtonTheme(
            minWidth: MediaQuery.of(context).size.width / 2,
            child: MaterialButton(
                onPressed: () {},
                child: Text('ЧАТЫ'),
                color: Colors.lightBlue[50]),
          ),
          ButtonTheme(
            minWidth: MediaQuery.of(context).size.width / 2,
            child: MaterialButton(
                onPressed: () {}, child: Text('ГРУППЫ'), color: Colors.white),
          ),
        ],
      ),
    );

    List conversationList = [
      {
        "name": "Максим Поварницын",
        "imageUrl":
            'https://sun9-10.userapi.com/impf/c851336/v851336995/1a0890/9WNHdaWfLf8.jpg?size=608x1080&quality=96&sign=ef85cc690dc3a5a465988cfcc55ea72f&type=album',
        "isOnline": true,
        "isReaded": false,
        "message": "ахпхапах",
        "time": "сейчас"
      },
      {
        "name": "Ариана Гранде",
        "imageUrl":
            'https://avatars.mds.yandex.net/get-zen_doc/1545908/pub_5e8f53b0a15b2a612ad8a1bd_5e8f72f0a095c13d82ff77f9/scale_1200',
        "isOnline": false,
        "isReaded": true,
        "message": "uwww",
        "time": "3м"
      },
      {
        "name": "Андрей Федосеев",
        "imageUrl":
            'https://sun9-53.userapi.com/impf/c855120/v855120889/211d2d/Si44Zgxt65Q.jpg?size=1280x1279&quality=96&sign=8d41bb8c3e7259677767a089bdecae9d&type=album',
        "isOnline": true,
        "isReaded": true,
        "message": "я дурачок",
        "time": "14:43"
      },
      {
        "name": "Вадик Куликов",
        "imageUrl": 'https://vk.com/images/camera_200.png',
        "isOnline": true,
        "isReaded": false,
        "message": "мне пихуй",
        "time": "10:15"
      },
      {
        "name": "Ирина Аллегрова",
        "imageUrl":
            'https://amazingpage.ru/wp-content/uploads/2020/03/65f258208b2080294b47f1abfb01b8ff.jpg',
        "isOnline": false,
        "isReaded": false,
        "message": "трек новый написала",
        "time": "вчера"
      },
      {
        "name": "Donald J. Trump",
        "imageUrl":
            'https://upload.wikimedia.org/wikipedia/commons/d/dd/Donald_Trump_2013_cropped_more.jpg',
        "isOnline": true,
        "isReaded": false,
        "message": "печатает..",
        "time": "вчера"
      },
      {
        "name": "Владимир Путин",
        "imageUrl":
            'https://evo-rus.com/wp-content/uploads/2020/06/scale_1200-42.jpg',
        "isOnline": false,
        "isReaded": false,
        "message": "Мейк раша грит эгейн",
        "time": "2 февраля"
      },
      {
        "name": "Алексей Навальный",
        "imageUrl":
            'https://evo-rus.com/wp-content/uploads/2020/08/877181_original.jpg',
        "isOnline": true,
        "isReaded": true,
        "message": "Придешь?",
        "time": "23 января"
      }
    ];

    final String assetNamePath = 'assets/images/Maxim_photo.png';
    final String imageNetwork =
        'https://avatars.mds.yandex.net/get-zen_doc/1545908/pub_5e8f53b0a15b2a612ad8a1bd_5e8f72f0a095c13d82ff77f9/scale_1200';

    AssetImage ImageFromAssetImage = AssetImage(assetNamePath);
    Image ImageFromNetwork = Image.network(imageNetwork);

    _conversations(BuildContext context) {
      return Column(
        children: List.generate(conversationList.length, (index) {
          return InkWell(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: Image.network(
                                          conversationList[index]['imageUrl'])
                                      .image,
                                  fit: BoxFit.cover)),
                        ),
                        conversationList[index]['isOnline']
                            ? Positioned(
                                top: 38,
                                left: 42,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF66BB6A),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Color(0xFFFFFFFF), width: 3)),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        conversationList[index]['name'],
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      conversationList[index]['isReaded']
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width - 135,
                              child: Text(
                                conversationList[index]['message'] +
                                    " - " +
                                    conversationList[index]['time'],
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF000000).withOpacity(0.7)),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          : SizedBox(
                              width: MediaQuery.of(context).size.width - 135,
                              child: Text(
                                conversationList[index]['message'] +
                                    " - " +
                                    conversationList[index]['time'],
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF000000).withOpacity(1.0)),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                    ],
                  )
                ],
              ),
            ),
          );
        }),
      );
    }

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: ListView(
            physics: BouncingScrollPhysics(),
            // crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 24.0, width: double.infinity),
              appBar,
              Chats_Groups,
              SizedBox(
                height: 10,
              ),
              _conversations(context)
            ],
          ),
        ),
      ),
    );
  }
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
        child: Row(
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
      )),
    );
  }
}
