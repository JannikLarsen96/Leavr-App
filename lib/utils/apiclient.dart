import 'package:http/http.dart' as http;
import 'dart:convert';
import '../conversationlist.dart';
import '../chatmessage.dart';

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
