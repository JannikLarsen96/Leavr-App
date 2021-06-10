import 'package:flutter/material.dart';

class LicensePlateList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LicensePlateListState();
  }
}

class LicensePlateListState extends State<LicensePlateList> {
  var licensePlates = <String>['CL 62 711', 'AB 12 345'];

  void addLicensePlate(BuildContext context) {
    showAlertDialog(context);
  }

  var textController = TextEditingController();

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Tilføj nummerplade"),
      content: TextField(
        decoration: InputDecoration(
            hintText: "Skriv besked",
            hintStyle: TextStyle(color: Colors.black54),
            border: InputBorder.none),
        autofocus: true,
        controller: textController,
      ),
      actions: [
        ElevatedButton(
          child: Text("OK"),
          onPressed: () {
            setState(() {
              licensePlates.add(textController.text);
              textController.text = '';
            });

            Navigator.pop(context);
          },
        )
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var result = <LicensePlate>[];

    for (var i = 0; i < licensePlates.length; i++) {
      result.add(LicensePlate(licensePlates[i], Key(licensePlates[i])));
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: result.length,
            itemBuilder: (context, index) {
              return Container(
                child: result[index],
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => addLicensePlate(context), child: Icon(Icons.add)),
    );
  }
}

class LicensePlate extends StatelessWidget {
  String licensePlate;

  LicensePlate(this.licensePlate, Key key) : super(key: key);

  void pressed() {
    print(licensePlate);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(Icons.directions_car), title: Text(licensePlate));
  }
}
