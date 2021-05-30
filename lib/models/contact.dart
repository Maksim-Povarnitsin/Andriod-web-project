import 'package:cloud_firestore/cloud_firestore.dart';

class Contact {
  final String id;
  final String email;
  final String image;
  final Timestamp lastseen;
  final String name;

  Contact({this.id, this.email, this.name, this.image, this.lastseen});

  factory Contact.fromFirestore(DocumentSnapshot _snapshot) {
    return Contact(
      id: _snapshot.id,
      lastseen: _snapshot.get("lastSeen"),
      email: _snapshot.get("email"),
      name: _snapshot.get("name"),
      image: _snapshot.get("image"),
    );
  }
}
