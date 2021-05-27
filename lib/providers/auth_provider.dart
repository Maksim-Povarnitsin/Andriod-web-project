import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

enum AuthStatus {
  NotAuthenticated,
  Authenticating,
  Authenticated,
  UserNotFound,
  Error
}

class AuthProvider extends ChangeNotifier {
  User user;
  AuthStatus status; // храним текущий статус авторизации
  FirebaseAuth _auth;

  static AuthProvider instance = AuthProvider();

  AuthProvider() {
    _auth = FirebaseAuth.instance;
  }

  void loginUserWithEmailAndPassword(String _email, String _pass) async {
    status = AuthStatus.Authenticating;
    notifyListeners(); // оповестить подписчиков о своем статусе
    try {
      UserCredential _result = await _auth.signInWithEmailAndPassword(
          email: _email, password: _pass);
      user = _result.user;
      status = AuthStatus.Authenticated;
      print("Logged in");
      //Перейти на главную страницу
    } catch (e) {
      status = AuthStatus.Error;
      print("Login Error");
      // Показать ошибку
    }
    notifyListeners();
  }
}
