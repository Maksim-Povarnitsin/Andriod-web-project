import 'package:chatik_app/models/conversation.dart';
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

  Stream<Contact> getUserData(String _uid) {
    var _ref = _db.collection(_userCollection).doc(_uid);
    return _ref.get().asStream().map((_snapshot) {
      return Contact.fromFirestore(_snapshot);
    });
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
}
