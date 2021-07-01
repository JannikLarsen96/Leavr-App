import 'package:flutter/services.dart';

class LicensePlateTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var lastIndex = text.length - 1;

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == lastIndex && (i == 1 || i == 4)) {
        buffer.write(' ');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string.toUpperCase(),
        selection: new TextSelection.collapsed(offset: string.length));
  }
}
