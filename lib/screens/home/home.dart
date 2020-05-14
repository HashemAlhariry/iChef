import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ichef/screens/home/recipeslist.dart';
import 'package:ichef/services/auth.dart';
import 'package:ichef/models/user.dart';
import 'package:ichef/services/database.dart';
import 'package:provider/provider.dart';
import 'package:ichef/models/recipe.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().recipes,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "iChef",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red[400],
          elevation: 0.0,
          actions: <Widget>[
            new IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: null),
          ],
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: Text("USERNAME  "),
                accountEmail: Text("EMAIL ACOUNT"),
                currentAccountPicture: GestureDetector(
                  child: new CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ),
                decoration: new BoxDecoration(color: Colors.red[400]),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('Home Page'), leading: Icon(Icons.home)),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('My Orders'),
                    leading: Icon(Icons.shopping_cart)),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('Favourites'), leading: Icon(Icons.favorite)),
              ),
              Divider(),
              InkWell(
                onTap: () async {
                  await _auth.signOut();
                },
                child: ListTile(
                    title: Text('Log out'), leading: Icon(Icons.person,color: Colors.red )),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('About'), leading: Icon(Icons.help_outline,color: Colors.blue)),
              ),
            ],
          ),
        ),
        body: new Container(
          child: new Column(
          children: <Widget>[
            new Flexible(child: RecipesList()),
            new Flexible(child: RecipesList()),
          ],

        )



        ),
      ),
    );
  }
}
