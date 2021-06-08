import 'dart:async';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  var currentUser;

  Future getUser() {
    return Future.value(currentUser);
  }

  // wrappinhg the firebase calls
  Future logout() {
    this.currentUser = null;
    notifyListeners();
    return Future.value(currentUser);
  }

  Future createUser(String email, String password, String confirmPassword) {
    print('creating user');
    this.currentUser = {'email': email};
    notifyListeners();
    return Future.value(currentUser);
  }

  // logs in the user if password matches
  Future loginUser(String email, String password) {
    print('made it to login user');
    if (password == 'password123') {
      this.currentUser = {'email': email};
      notifyListeners();
      return Future.value(currentUser);
    } else {
      this.currentUser = null;
      return Future.value(null);
    }
  }
}
