import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leavr_app/components/text/licenseplatetextformatter.dart';

class LicensePlateTextBox extends StatelessWidget {
  TextEditingController textController;

  LicensePlateTextBox(this.textController);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: "Skriv besked",
          hintStyle: TextStyle(color: Colors.black54),
          border: InputBorder.none),
      autofocus: true,
      controller: textController,
      inputFormatters: [
        LicensePlateTextFormatter(),
        FilteringTextInputFormatter.allow(
            RegExp(r"^[A-Za-z]{0,2}( \d{0,2})?( \d{0,3})?")),
      ],
    );
  }
}
