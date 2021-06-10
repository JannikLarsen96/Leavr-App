import 'package:flutter/material.dart';
import './licenseplatelist.dart';
import './conversationlist.dart';
import './auth/authservice.dart';
import 'login_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider<AuthService>(
    child: LeavRApp(),
    create: (BuildContext context) {
      return AuthService();
    }));

class LeavRApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: Provider.of<AuthService>(context).getUser(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.hasData ? LeavRAppHome() : LoginPage();
          } else {
            return Container(color: Colors.white);
          }
        },
      ),
    );
  }
}

class LeavRAppHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LeavRAppHomeState();
}

class LeavRAppHomeState extends State<LeavRAppHome> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const Text(
      'Index 0: Home',
    ),
    ConversationList(),
    LicensePlateList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LeavR'),
        backgroundColor: Color.fromRGBO(144, 190, 240, 1),
      ),
      body: _widgetOptions[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Oversigt',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Beskeder',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Mine biler',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue[200],
        onTap: onItemTapped,
      ),
    );
  }
}
