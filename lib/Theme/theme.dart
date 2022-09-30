import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

final Shader linearGradient = const LinearGradient(
  colors: <Color>[Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 0, 0, 0)],
).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));


changeTheme() {
  Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
}

TextStyle textStyleHead() {
  return const TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
}

TextStyle textStyleHead2() {
  return  TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400,foreground: Paint()..shader = linearGradient);
      
}

TextStyle textStyle() {
  return const TextStyle(
      fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white);
}

TextStyle textStyleDrawer() {
  return const TextStyle(
      fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey);
}

ButtonStyle buttonStyle(Color color) {
  return ElevatedButton.styleFrom(
    primary: color,
  );
}

BoxDecoration appDecoration() {
  return const BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(255, 174, 16, 148),
          Color.fromARGB(255, 23, 85, 156)
        ]),
  );
}
