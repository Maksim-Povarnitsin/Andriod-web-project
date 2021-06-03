import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message.dart';

class ConversationSnippet {
  final String id;
  final String conversationID;
  final String lastMessage;
  final String name;
  final String image;
  final String unseenCount;
  final Timestamp timestamp;

  ConversationSnippet(
      {this.conversationID,
      this.id,
      this.lastMessage,
      this.unseenCount,
      this.timestamp,
      this.name,
      this.image});

  factory ConversationSnippet.fromFirestore(DocumentSnapshot _snapshot) {
    var _data = _snapshot.data();
    return ConversationSnippet(
        id: _snapshot.id,
        conversationID: _snapshot.get("ConversationID"),
        lastMessage: _snapshot.get("lastMessage") != null
            ? _snapshot.get("lastMessage")
            : "",
        unseenCount: _snapshot.get("unseenCount"),
        timestamp: _snapshot.get("timestamp"),
        name: _snapshot.get("name"),
        image: _snapshot.get("image"));
  }
}

class Conversation {
  final String id;
  final List members;
  final List<Message> messages;
  final String conversationID;

  Conversation({this.id, this.members, this.conversationID, this.messages});

  factory Conversation.fromFirestore(DocumentSnapshot _snapshot) {
    var _data = _snapshot.data();
    List _messages = _snapshot.get("messages");
    if (_messages != null) {
      _messages = _messages.map((_m) {
        var _messageType =
            _m["type"] == "text" ? MessageType.Text : MessageType.Image;
        return Message(
            senderID: _m["senderID"],
            content: _m["message"],
            timestamp: _m["timestamp"],
            type: _messageType);
      }).toList();
    }
    return Conversation(
        id: _snapshot.id,
        members: _snapshot.get("members"),
        conversationID: _snapshot.get("conversationID"),
        messages: _messages);
  }
}
