import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ichef/screens/home/recipeslist.dart';
import 'package:ichef/services/auth.dart';
import 'package:ichef/models/user.dart';
import 'package:ichef/services/database.dart';
import 'package:provider/provider.dart';
import 'package:ichef/models/recipe.dart';

class Home extends StatelessWidget {


  final AuthService _auth= AuthService();

  @override
  Widget build(BuildContext context) {


    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().recipes,
      child: Scaffold(
        appBar: AppBar(
          title: Text("iChef" ,style: TextStyle(color: Colors.red[400]),),
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.person), label: Text('Logout'),
                onPressed: () async {
                await _auth.signOut();
                })
          ],
        ),
        body: RecipesList(),
      ),
    );
  }
}
