import 'package:flutter/material.dart';
import 'package:ichef/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:ichef/models/user.dart';
import 'package:ichef/screens/Authenticate/authenticate.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);
    //return either Home or Authenticate widget
    if(user == null ) {
        return Authenticate();
      } else {
        return Home();
      }
  }
}
