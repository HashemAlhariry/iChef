import 'package:flutter/material.dart';
import 'package:ichef/screens/Authenticate/authenticate.dart';
import 'package:ichef/screens/Authenticate/login.dart';
import 'package:ichef/screens/Authenticate/signup.dart';
import 'package:ichef/screens/wrapper.dart';
import 'package:ichef/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:ichef/models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper()
      ),
    );
  }

}