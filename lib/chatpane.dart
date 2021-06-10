import 'package:flutter/material.dart';
import 'utils/apiclient.dart';
import './chatmessage.dart';

class Conversation extends StatefulWidget {
  final String title;
  final String licensePlate;
  final int id;
  Conversation(this.id, this.licensePlate, this.title);

  @override
  State<StatefulWidget> createState() =>
      ConversationState(id, licensePlate, title);
}

class ConversationState extends State<Conversation> {
  final String title;
  final String licensePlate;
  final int id;
  ConversationState(this.id, this.licensePlate, this.title);
  final textController = TextEditingController();

  var dataLoaded = false;
  var messages = <ChatMessage>[];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  loadData() async {
    var apiMessages = await ApiClient.fetchConversation(id);
    if (!mounted) {
      return;
    }
    setState(() {
      messages = apiMessages;
      dataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          FutureBuilder<List<ChatMessage>>(
              future: ApiClient.fetchConversation(id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (dataLoaded && snapshot.hasData) {
                  messages = snapshot.data;
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment: (messages[index].messageType == "receiver"
                              ? Alignment.topLeft
                              : Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (messages[index].messageType == "receiver"
                                  ? Colors.grey.shade200
                                  : Colors.blue[200]),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              messages[index].messageContent,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                          hintText: "Skriv besked",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                      controller: textController,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        messages.add(ChatMessage(
                            licensePlate, textController.text, 'sender'));
                      });
                      textController.text = '';
                    },
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
