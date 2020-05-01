import 'package:flutter/material.dart';
import 'package:ichef/screens/Authenticate/authenticate.dart';
import 'package:ichef/screens/Authenticate/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Authenticate()
    );
  }
}