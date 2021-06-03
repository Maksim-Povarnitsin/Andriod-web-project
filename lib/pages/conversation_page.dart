import 'dart:async';
import 'dart:io';

import 'package:chatik_app/models/conversation.dart';
import 'package:chatik_app/services/cloud_storage_service.dart';
import 'package:chatik_app/services/media_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';

import '../services/database_service.dart';
import '../providers/auth_provider.dart';
import '../models/message.dart';

class ConversationPage extends StatefulWidget {
  String _conversationID;
  String _receiverID;
  String _receiverImage;
  String _receiverName;

  ConversationPage(this._conversationID, this._receiverID, this._receiverName,
      this._receiverImage);

  @override
  State<StatefulWidget> createState() {
    return _ConversationPageState();
  }
}

class _ConversationPageState extends State<ConversationPage> {
  double _deviceHeight;
  double _deviceWidth;

  GlobalKey<FormState> _formKey;
  AuthProvider _auth;
  String _messageText;
  ScrollController _listViewController;

  _ConversationPageState() {
    _formKey = GlobalKey<FormState>();
    _listViewController = ScrollController();
    _messageText = "";
  }
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(31, 31, 31, 1.0),
        title: Text(this.widget._receiverName),
      ),
      body: ChangeNotifierProvider<AuthProvider>.value(
        value: AuthProvider.instance,
        child: _createConversationPage(),
      ),
    );
  }

  Widget _createConversationPage() {
    return Builder(builder: (BuildContext _context) {
      _auth = Provider.of<AuthProvider>(_context);
      return Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          _messageListView(),
          Align(
            alignment: Alignment.bottomCenter,
            child: _messageField(_context),
          ),
        ],
      );
    });
  }

  Widget _messageListView() {
    return Container(
        height: _deviceHeight * 0.75,
        width: _deviceWidth,
        child: StreamBuilder<Conversation>(
          stream: DatabaseService.instance
              .getConversation(this.widget._conversationID),
          builder: (BuildContext _context, _snapshot) {
            Timer(
              Duration(microseconds: 50),
              () {
                _listViewController
                    .jumpTo(_listViewController.position.maxScrollExtent);
              },
            );
            var _conversationData = _snapshot.data;
            if (_conversationData != null) {
              return ListView.builder(
                controller: _listViewController,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                itemCount: _conversationData.messages.length,
                itemBuilder: (BuildContext _context, int _index) {
                  var _message = _conversationData.messages[_index];
                  bool _isOwnMessage = _message.senderID == _auth.user.uid;
                  return _messageListViewChild(_isOwnMessage, _message);
                },
              );
            } else {
              return SpinKitWanderingCubes(
                color: Colors.blue,
                size: 50,
              );
            }
          },
        ));
  }

  Widget _messageListViewChild(bool _isOwnMessage, Message _message) {
    return Padding(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            _isOwnMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          !_isOwnMessage ? _userImageWidget() : Container(),
          _message.type == MessageType.Text
              ? _textMessage(
                  _isOwnMessage, _message.content, _message.timestamp)
              : _imageMessage(
                  _isOwnMessage, _message.content, _message.timestamp)
        ],
      ),
      padding: EdgeInsets.only(bottom: 10),
    );
  }

  Widget _userImageWidget() {
    double _imageRadius = _deviceHeight * 0.05;
    return Container(
      height: _imageRadius,
      width: _imageRadius,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(500),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(this.widget._receiverImage),
        ),
      ),
    );
  }

  Widget _textMessage(
      bool _isOwnMessage, String _message, Timestamp _timestamp) {
    List<Color> _colorScheme = _isOwnMessage
        ? [Colors.blue, Color.fromRGBO(42, 117, 188, 1)]
        : [Color.fromRGBO(69, 69, 69, 1), Color.fromRGBO(43, 43, 43, 1)];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: _deviceHeight * 0.10 + (_message.length / 20 * 5.0),
      width: _deviceWidth * 0.75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: _colorScheme,
          stops: [0.30, 0.70],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(_message),
          Text(
            timeago.format(_timestamp.toDate()),
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _messageField(BuildContext _context) {
    return Container(
      height: _deviceHeight * 0.08,
      decoration: BoxDecoration(
        color: Color.fromRGBO(43, 43, 43, 1),
        borderRadius: BorderRadius.circular(100),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: _deviceWidth * 0.04,
        vertical: _deviceHeight * 0.03,
      ),
      child: Form(
        key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _messageTextField(),
            _sendMessageButton(_context),
            _imageMessageButton(),
          ],
        ),
      ),
    );
  }

  Widget _messageTextField() {
    return SizedBox(
      width: _deviceWidth * 0.55,
      child: TextFormField(
        validator: (_input) {
          if (_input.length == 0) {
            return "Введите сообщение";
          }
          return null;
        },
        onChanged: (_input) {
          _formKey.currentState.save();
        },
        onSaved: (_input) {
          setState(() {
            _messageText = _input;
          });
        },
        cursorColor: Colors.white,
        decoration: InputDecoration(
            border: InputBorder.none, hintText: "Введите сообщение"),
        autocorrect: false,
      ),
    );
  }

  Widget _sendMessageButton(BuildContext _context) {
    return Container(
      height: _deviceHeight * 0.05,
      width: _deviceHeight * 0.05,
      child: IconButton(
        icon: Icon(
          Icons.send,
          color: Colors.white,
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            DatabaseService.instance.sendMessage(
              this.widget._conversationID,
              Message(
                content: _messageText,
                timestamp: Timestamp.now(),
                senderID: _auth.user.uid,
                type: MessageType.Text,
              ),
            );
            _formKey.currentState.reset();
            FocusScope.of(_context).unfocus();
          }
        },
      ),
    );
  }

  Widget _imageMessageButton() {
    return Container(
      height: _deviceHeight * 0.05,
      width: _deviceHeight * 0.05,
      child: FloatingActionButton(
        onPressed: () async {
          var _pickedImage = await MediaService.instance.getImageFromLibrary();
          if (_pickedImage != null) {
            File _image = File(_pickedImage.path);
            var _result = await CloudStorageService.instance
                .uploadMediaMessage(_auth.user.uid, _image);
            var _imageURL = await _result.ref.getDownloadURL();
            await DatabaseService.instance.sendMessage(
              this.widget._conversationID,
              Message(
                content: _imageURL,
                senderID: _auth.user.uid,
                timestamp: Timestamp.now(),
                type: MessageType.Image,
              ),
            );
          }
        },
        child: Icon(Icons.camera_enhance),
      ),
    );
  }

  Widget _imageMessage(
      bool _isOwnMessage, String _imageURL, Timestamp _timestamp) {
    List<Color> _colorScheme = _isOwnMessage
        ? [Colors.blue, Color.fromRGBO(42, 117, 188, 1)]
        : [Color.fromRGBO(69, 69, 69, 1), Color.fromRGBO(43, 43, 43, 1)];
    DecorationImage _image =
        DecorationImage(image: NetworkImage(_imageURL), fit: BoxFit.cover);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: _colorScheme,
          stops: [0.30, 0.70],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: _deviceHeight * 0.30,
            width: _deviceWidth * 0.40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: _image,
            ),
          ),
          Text(
            timeago.format(_timestamp.toDate()),
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
