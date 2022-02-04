import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextFormField buildTextFormField(labeltext, controller) {
  return TextFormField(
    decoration: InputDecoration(labelText: labeltext),
    controller: controller,
  );
}

TextFormField buildTextFormFieldPassword(label, controller) {
  return TextFormField(
    decoration: InputDecoration(labelText: label),
    obscureText: true,
    maxLengthEnforcement: MaxLengthEnforcement.none,
    maxLength: 20,
    controller: controller,
  );
}
