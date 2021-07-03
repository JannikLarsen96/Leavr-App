import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leavr_app/components/text/licenseplatetextformatter.dart';

class StartConversationTextBox extends StatelessWidget {
  TextEditingController textController;

  StartConversationTextBox(this.textController);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: "XY 12345",
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
