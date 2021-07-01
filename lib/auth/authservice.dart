import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/apiclient.dart';
import '../models/user.dart';

class AuthService with ChangeNotifier {
  User? currentUser;

  Future<User?> getUser() {
    return Future.value(currentUser);
  }

  // wrappinhg the firebase calls
  Future logout() {
    currentUser = null;
    notifyListeners();
    return Future.value(currentUser);
  }

  Future loginUser(String deviceId) async {
    var user = await ApiClient.GetUser(deviceId);
    user ??= await ApiClient.CreateUser(deviceId);
    notifyListeners();
    currentUser = user;
    return Future.value(currentUser);
  }
}
