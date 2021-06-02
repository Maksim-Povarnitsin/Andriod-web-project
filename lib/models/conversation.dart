import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationSnippet {
  final String id;
  final String conversationID;
  final String lastMessage;
  final String name;
  final String image;
  final int unseenCount;
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
