import 'package:chatik_app/models/conversation.dart';
import 'package:chatik_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/contact.dart';

class DatabaseService {
  static DatabaseService instance = DatabaseService();

  FirebaseFirestore _db;

  DatabaseService() {
    _db = FirebaseFirestore.instance;
  }

  String _userCollection = "Users";
  String _conversationsCollection = "Conversations";

  Future<void> createUser(
      String _uid, String _name, String _email, String _imageURL) async {
    try {
      return await _db.collection(_userCollection).doc(_uid).set({
        "name": _name,
        "email": _email,
        "image": _imageURL,
        "lastSeen": DateTime.now().toLocal(),
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUserLastSeenTime(String _uid) {
    var _ref = _db.collection(_userCollection).doc(_uid);
    return _ref.update({"lastSeen": Timestamp.now()});
  }

  Future<void> sendMessage(String _conversationID, Message _message) {
    var _ref = _db.collection(_conversationsCollection).doc(_conversationID);
    var _messageType = "";
    switch (_message.type) {
      case (MessageType.Text):
        _messageType = "text";
        break;
      case (MessageType.Image):
        _messageType = "image";
        break;
    }
    return _ref.update({
      "messages": FieldValue.arrayUnion(
        [
          {
            "message": _message.content,
            "senderID": _message.senderID,
            "timestamp": _message.timestamp,
            "type": _messageType,
          },
        ],
      ),
    });
  }

  Stream<Contact> getUserData(String _uid) {
    var _ref = _db.collection(_userCollection).doc(_uid);
    return _ref.get().asStream().map((_snapshot) {
      return Contact.fromFirestore(_snapshot);
    });
  }

  Future<void> createOrGetConversation(String _uid, String _recepientID,
      Future<void> _onSuccess(String _conversationID)) async {
    var _ref = _db.collection(_conversationsCollection);
    var _userConversationRef = _db
        .collection(_userCollection)
        .doc(_uid)
        .collection(_conversationsCollection);
    try {
      var conversation = await _userConversationRef.doc(_recepientID).get();
      if (conversation.data() != null) {
        //если чат уже есть
        return _onSuccess(conversation.data()["conversationID"]);
      } else {
        // если нет
        var _conversationRef = _ref.doc();
        await _conversationRef.set({
          "members": [_uid, _recepientID],
          "ownerID": _uid,
          "messages": [],
        });
        return _onSuccess(_conversationRef.id);
      }
    } catch (e) {
      print(e);
    }
  }

  Stream<List<ConversationSnippet>> getUserConversations(String _uid) {
    List<ConversationSnippet> snippets = new List();
    var _ref = _db
        .collection(_userCollection)
        .doc(_uid)
        .collection(_conversationsCollection)
        .snapshots();
    _ref.forEach((elemen) {
      elemen.docs.forEach((element) {
        snippets.add(ConversationSnippet.fromFirestore(element));
      });
    });
    return Stream.value(snippets);
  }

  Stream<List<Contact>> getUsers(String _searchName) {
    List<Contact> users = new List();
    var _ref = _db.collection(_userCollection).snapshots();
    _ref.forEach((elemen) {
      elemen.docs.forEach((element) {
        users.add(Contact.fromFirestore(element));
      });
    });
    return Stream.value(users);
  }

  Stream<Conversation> getConversation(String _conversationID) {
    var _ref = _db.collection(_conversationsCollection).doc(_conversationID);
    return _ref.snapshots().map((_snapshot) {
      print(_snapshot.get("image"));
      return Conversation.fromFirestore(_snapshot);
    });
  }
}
