import 'package:flutter/material.dart';
import 'utils/apiclient.dart';
import 'models/vehicle.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class LicensePlateList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LicensePlateListState();
  }
}

class LicensePlateListState extends State<LicensePlateList> {
  void addLicensePlate(BuildContext context) {
    showAlertDialog(context);
  }

  void _updateView(BuildContext context) {
    setState(() => {build(context)});
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
          onPressed: () async {
            await ApiClient.AddVehicle(context, textController.text);
            setState(() {
              textController.text = '';
              build(context);
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
    return FutureBuilder<List<Vehicle>>(
      future: ApiClient.getVehicles(context),
      builder: (BuildContext context, AsyncSnapshot<List<Vehicle>> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Stack(
              children: <Widget>[
                ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: LicensePlate(
                          snapshot.data?[index].plate ?? '',
                          () => _updateView(context),
                          Key(snapshot.data?[index].plate ?? '')),
                    );
                  },
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () => addLicensePlate(context),
                child: Icon(Icons.add)),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class LicensePlate extends StatelessWidget {
  String licensePlate;
  final Function update;

  LicensePlate(this.licensePlate, this.update, Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      key: Key(licensePlate),
      actionExtentRatio: 0.25,
      child: ListTile(
          leading: Icon(Icons.directions_car), title: Text(licensePlate)),
      secondaryActions: <Widget>[
        IconSlideAction(
            caption: 'Slet',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => _promptDeleteVehicle(context)),
      ],
    );
  }

  void _promptDeleteVehicle(BuildContext context) {
    Widget continueButton = ElevatedButton(
      child: Text("Slet"),
      style: ElevatedButton.styleFrom(primary: Colors.red),
      onPressed: () async {
        await _deleteVehicle(context);
        update();
        Navigator.pop(context);
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Fortryd"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Er du sikker?"),
      content: Text("Er du sikker på, at du vil slette køretøjet " +
          licensePlate +
          " fra din konto?"),
      actions: [
        cancelButton,
        continueButton,
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

  Future _deleteVehicle(BuildContext context) async {
    await ApiClient.DeleteVehicle(context, licensePlate);
  }
}
