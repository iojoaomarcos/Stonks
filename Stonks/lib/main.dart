import 'package:flutter/material.dart';
import 'package:projeto_final_acoes/login/login_page.dart';

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
    theme: ThemeData(
      hintColor: Colors.blueAccent,
      primaryColor: Colors.blueAccent,
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          hintStyle: TextStyle(color: Colors.white)),
    ),
    debugShowCheckedModeBanner: false,
  ));
}
