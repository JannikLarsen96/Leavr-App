import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:leavr_app/utils/apiclientbase.dart';
import 'dart:convert';
import '../conversationlist.dart';
import '../chatmessage.dart';
import '../models/user.dart';
import '../models/vehicle.dart';
import 'package:flutter/material.dart';
import 'apiclientbase.dart';

class ApiClient {
  static const String apiUrl = '60ba42d25cf7140017696e85.mockapi.io';

  static Future<User?> GetUser(String appIdentifier) async {
    var queryParameters = {'appIdentifier': appIdentifier};

    var uri = Uri.http('api.leavr.org', 'User/appIdentifier', queryParameters);
    //TODO: Add error handling
    var httpResult = await http.get(uri);

    if (httpResult.statusCode == 404) {
      return null;
    }

    dynamic jsonResult = json.decode(httpResult.body);

    return User(
        jsonResult['id'],
        jsonResult['appIdentifier'],
        jsonResult['maxVehicles'],
        jsonResult['isDeleted'],
        DateTime.parse(jsonResult['createdAt']));
  }

  static Future<User?> CreateUser(String appIdentifier) async {
    var queryParameters = {'appIdentifier': appIdentifier};
    var uri = Uri.http('api.leavr.org', 'User', queryParameters);
    //TODO: Add error handling
    var httpResult = await http.post(uri);
    return GetUser(appIdentifier);
  }

  static Future<List<Vehicle>> getVehicles(BuildContext context) async {
    var uri = Uri.http('api.leavr.org', 'Vehicle');
    //TODO: Add error handling
    var httpResult = await ApiClientBase.get(context, uri);

    List<dynamic> jsonResult = json.decode(httpResult.body);

    List<Vehicle> items = <Vehicle>[];

    for (var item in jsonResult) {
      items.add(Vehicle(item['plate']));
    }

    return items;
  }

  static Future AddVehicle(BuildContext context, String licensePlate) async {
    var uri = Uri.http('api.leavr.org', 'Vehicle');

    //TODO: Add error handling
    await ApiClientBase.post(context, uri,
        body: jsonEncode(AddVehicleModel(licensePlate)));
  }

  static Future DeleteVehicle(BuildContext context, String licensePlate) async {
    var uri = Uri.http('api.leavr.org', 'Vehicle');

    //TODO: Add error handling
    var response = await ApiClientBase.delete(context, uri,
        body: jsonEncode(AddVehicleModel(licensePlate)));

    var a = 0;
  }

  //[{"id":"1","licensePlate":"AB 12 341","messages":[{"messageContent":"Lorem ipsum jada jada","messageType":"receiver"},{"messageContent":"Lorem ipsum jada jada","messageType":"sender"}]}]
  static Future<List<ChatMessage>> fetchConversation(int id) async {
    var idString = id.toString();

    var uri = Uri.https(apiUrl, 'conversation', {'id': idString});
    //TODO: Add error handling
    var httpResult = await http.get(uri);

    List<dynamic> jsonResult = json.decode(httpResult.body);

    List<ChatMessage> items = <ChatMessage>[];

    var licensePlate = jsonResult[0]['licensePlate'];

    for (var item in jsonResult[0]['messages']) {
      items.add(ChatMessage(
          licensePlate, item["messageContent"], item["messageType"]));
    }

    return items;
  }

  static Future<List<ConversationListItem>> fetchConversations() async {
    var uri = Uri.https(apiUrl, 'conversations');
    //TODO: Add error handling
    var httpResult = await http.get(uri);

    List<dynamic> jsonResult = json.decode(httpResult.body);

    List<ConversationListItem> items = <ConversationListItem>[];

    for (var item in jsonResult) {
      items.add(ConversationListItem(
          int.parse(item["id"]), item["licensePlate"], item["subject"]));
    }

    return items;
  }
}

class AddVehicleModel {
  String plate;
  AddVehicleModel(this.plate);

  Map<String, dynamic> toJson() => {'plate': plate};
}
