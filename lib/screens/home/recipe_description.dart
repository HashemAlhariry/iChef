import 'package:flutter/material.dart';
import 'package:ichef/models/recipe.dart';
import 'package:ichef/services/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RecipeDescription extends StatefulWidget {
  final Recipe recipe;

  RecipeDescription({this.recipe});

  @override
  _RecipeDescriptionState createState() => _RecipeDescriptionState();
}

class _RecipeDescriptionState extends State<RecipeDescription> {
  final AuthService _auth = AuthService();
  String _downloadUrl;
  double _sizeOfCirclarImage = 330.0;
  double _sizeOfStepsImage= 150.0;

  @override
  void initState() {
    downloadImage();
    super.initState();
  }

  Future downloadImage() async {
    final ref = FirebaseStorage.instance.ref().child(widget.recipe.image);
    String url = await ref.getDownloadURL();
    if (this.mounted) {
      setState(() {
        _downloadUrl = url;
      });
    }
  }



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
          widget.recipe.name,
          style: TextStyle(color: Colors.white, fontSize: 16),
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
              accountName: Text("USERNAME"),
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
                //await _auth.signOut();
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
      body: Center(
          child:
              ListView(padding: const EdgeInsets.all(10.0), children: <Widget>[
        _downloadUrl == null
            ? Container(
                width: _sizeOfCirclarImage,
                height: _sizeOfCirclarImage,
              )
            : Container(
                margin: EdgeInsets.all(10.0),
                width: _sizeOfCirclarImage,
                height: _sizeOfCirclarImage,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: new NetworkImage(_downloadUrl)))),
        SizedBox(
          height: 10.0,
        ),
        Text(
          widget.recipe.description +
              " plus add any new things you want to add to help us increase the description",
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Duration: " + widget.recipe.duration.toString(),
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Price: " + widget.recipe.price.toString() + " Pounds",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Ingridents: ",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 80,
          child: ListView.builder(
              itemExtent: 250,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.red[400],
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Center(
                        child: Column(
                      children: <Widget>[
                        Text(
                          "Ingredient: ${widget.recipe.ingredients[index].ingredient}",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Quantity: ${widget.recipe.ingredients[index].quantity}",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Measure: ${widget.recipe.ingredients[index].measure}",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                  ),
              itemCount: widget.recipe.ingredients.length),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Steps: ",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 250,
          width: 250,
          child: ListView.builder(
              itemExtent: 250,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Center(
                        child: Card(
                          margin: EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: InkWell(
                            child: Column(children: <Widget>[
                              _downloadUrl == null
                                  ? Container(
                                width: _sizeOfStepsImage,
                                height: _sizeOfStepsImage,
                              )
                                  : Container(
                                  width: _sizeOfStepsImage,
                                  height: _sizeOfStepsImage,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.cover,
                                          image: new NetworkImage(_downloadUrl)))),
                              Text(
                                "Description: " + widget.recipe.description,
                                style: TextStyle(fontSize: 14.0),
                              )
                            ]),
                          ),
                        )),
                  ),
              itemCount: widget.recipe.ingredients.length),
        ),
      ])),
    );
  }
}
