import 'package:flutter/material.dart';
import 'package:ichef/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth= AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Home"),
        backgroundColor: Colors.red[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person), label: Text('Logout'),
              onPressed: () async {
              await _auth.signOut();
              })
        ],
      ),
    );
  }
}
