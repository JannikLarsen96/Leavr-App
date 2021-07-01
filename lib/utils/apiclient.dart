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

  static Future<User?> getUser(String appIdentifier) async {
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

  static Future<User?> createUser(String appIdentifier) async {
    var queryParameters = {'appIdentifier': appIdentifier};
    var uri = Uri.http('api.leavr.org', 'User', queryParameters);
    //TODO: Add error handling
    var httpResult = await http.post(uri);
    return getUser(appIdentifier);
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

  static Future addVehicle(BuildContext context, String licensePlate) async {
    var uri = Uri.http('api.leavr.org', 'Vehicle');

    //TODO: Add error handling
    await ApiClientBase.post(context, uri,
        body: jsonEncode(AddVehicleModel(licensePlate)));
  }

  static Future deleteVehicle(BuildContext context, String licensePlate) async {
    var uri = Uri.http('api.leavr.org', 'Vehicle');

    //TODO: Add error handling
    await ApiClientBase.delete(context, uri,
        body: jsonEncode(AddVehicleModel(licensePlate)));
  }

  static Future sendMessage(
      BuildContext context, int conversationId, String content) async {
    var uri = Uri.http('api.leavr.org', 'Message');

    //TODO: Add error handling
    await ApiClientBase.post(context, uri,
        body: jsonEncode(SendMessageModel(conversationId, content)));
  }

  static Future<List<ChatMessage>> getMessages(
      BuildContext context, int id) async {
    var uri =
        Uri.http('api.leavr.org', 'Message', {'conversationId': id.toString()});
    //TODO: Add error handling
    var httpResult = await ApiClientBase.get(context, uri);

    dynamic jsonResult = json.decode(httpResult.body);

    List<ChatMessage> items = <ChatMessage>[];

    var licensePlate = jsonResult['plate'];

    for (var item in jsonResult['messages']) {
      items.add(ChatMessage(licensePlate, item["content"], item["isSender"]));
    }

    return items;
  }

  static Future<List<ConversationListItem>> fetchConversations(
      BuildContext context) async {
    var uri = Uri.http('api.leavr.org', 'Conversation');
    //TODO: Add error handling
    var httpResult = await ApiClientBase.get(context, uri);

    List<dynamic> jsonResult = json.decode(httpResult.body);

    List<ConversationListItem> items = <ConversationListItem>[];

    for (var item in jsonResult) {
      items.add(ConversationListItem(
          item['id'], item['plate'], item['latestMessage']));
    }
    return items;
  }
}

class AddVehicleModel {
  String plate;
  AddVehicleModel(this.plate);

  Map<String, dynamic> toJson() => {'plate': plate};
}

class SendMessageModel {
  int conversationId;
  String content;
  SendMessageModel(this.conversationId, this.content);

  Map<String, dynamic> toJson() =>
      {'conversationId': conversationId, 'content': content};
}
