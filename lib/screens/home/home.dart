import 'package:flutter/material.dart';
import 'package:ichef/screens/home/recipeslist.dart';
import 'package:ichef/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.short_text),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Text(
          "iChef",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[400],
        elevation: 0.0,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: null),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("USERNAME  "),
              accountEmail: Text("EMAIL ACOUNT"),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(color: Colors.red[400]),
            ),
            InkWell(
              onTap: () {},
              child:
                  ListTile(title: Text('Home Page'), leading: Icon(Icons.home)),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                  title: Text('My Orders'), leading: Icon(Icons.shopping_cart)),
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
                  title: Text('Log out'),
                  leading: Icon(Icons.person, color: Colors.red)),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                  title: Text('About'),
                  leading: Icon(Icons.help_outline, color: Colors.blue)),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text("Special Offers", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 120,
              child: ListView.builder(
                  itemExtent: 200,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                        color: Colors.red[500],
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Center(
                          child: Text(
                            "Offer Number ${index + 1}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  itemCount: 10),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text("Main Recipes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
          ),
          RecipesList()
        ],
      ),
    );
  }
}
