import 'package:agenda_telefone/UI/HomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: HomePage(),
      debugShowCheckedModeBanner: false,
     
    );
  }
}

