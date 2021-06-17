import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/apiclient.dart';


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

  Future loginUser(String deviceId) async {
    var user = await ApiClient.GetUser(deviceId);
    user ??= await ApiClient.CreateUser(deviceId);
    notifyListeners();
    currentUser = user;
    return Future.value(currentUser);
  }
}
