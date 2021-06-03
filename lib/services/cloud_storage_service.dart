import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageService {
  static CloudStorageService instance = CloudStorageService();

  FirebaseStorage _storage;

  Reference _baseRef;

  String _profileImages = "profile_images";
  String _messages = "messages";
  String _images = "images";

  CloudStorageService() {
    _storage = FirebaseStorage.instance;
    _baseRef = _storage.ref();
  }

  Future<TaskSnapshot> uploadUserImage(String _uid, File _image) async {
    try {
      return await _baseRef.child(_profileImages).child(_uid).putFile(_image);
    } catch (e) {
      print(e);
    }
  }

  Future<TaskSnapshot> uploadMediaMessage(String _uid, File _file) async {
    var _timestamp = DateTime.now();
    var _fileName = basename(_file.path);
    _fileName += "_${_timestamp.toString()}";
    try {
      return await _baseRef
          .child(_messages)
          .child(_uid)
          .child(_images)
          .child(_fileName)
          .putFile(_file);
    } catch (e) {
      print(e);
    }
  }
}
