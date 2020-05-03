import 'package:flutter/material.dart';
import 'package:ichef/screens/Authenticate/login.dart';
import 'package:ichef/screens/Authenticate/signup.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showForms=true;
  void toggleView(){
    setState(() => showForms = !showForms);
  }

  @override
  Widget build(BuildContext context) {
   if(showForms)
     {
       return Login(toggleView:toggleView);
     }
   else
     {
       return SignUp(toggleView:toggleView);
     }
  }
}
