import 'package:http/http.dart' as http;
import 'dart:convert';
import '../conversationlist.dart';
import '../chatmessage.dart';
import '../models/user.dart';

class ApiClient {
  static const String apiUrl = '60ba42d25cf7140017696e85.mockapi.io';

  static Future<List<ConversationListItem>> fetchConversations() async {
    var uri = Uri.https(apiUrl, 'conversations');

    var httpResult = await http.get(uri);

    List<dynamic> jsonResult = json.decode(httpResult.body);

    List<ConversationListItem> items = <ConversationListItem>[];

    for (var item in jsonResult) {
      items.add(ConversationListItem(
          int.parse(item["id"]), item["licensePlate"], item["subject"]));
    }

    return items;
  }

  static Future<User?> GetUser(String appIdentifier) async {
    var queryParameters = {'appIdentifier': appIdentifier};

    var uri = Uri.http('api.leavr.org', 'User/appIdentifier', queryParameters);

    var httpResult = await http.get(uri);

    if (httpResult.statusCode == 404) {
      print('no user found, creating');
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

    var httpResult = await http.post(uri);
    print('Created user');
    return GetUser(appIdentifier);
  }

//[{"id":"1","licensePlate":"AB 12 341","messages":[{"messageContent":"Lorem ipsum jada jada","messageType":"receiver"},{"messageContent":"Lorem ipsum jada jada","messageType":"sender"}]}]
  static Future<List<ChatMessage>> fetchConversation(int id) async {
    var idString = id.toString();

    var uri = Uri.https(apiUrl, 'conversation', {'id': idString});

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
}
