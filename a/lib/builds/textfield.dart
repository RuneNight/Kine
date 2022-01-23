import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextFormField buildTextFormField(labeltext,profile) {
  return TextFormField(
    decoration: InputDecoration(labelText: labeltext),
    onChanged: (text) {
      if (text.isNotEmpty){
        String profile = text;
      }
    },
  );
}

TextFormField buildTextFormFieldPassword(label,pass) {
  return TextFormField(
    decoration: InputDecoration(labelText: label),obscureText: true,
    maxLengthEnforcement: MaxLengthEnforcement.none,
    maxLength: 20,
    onChanged: (texts) {
      if (texts.isNotEmpty){
        String pass = texts;
      }
    },
  );
}