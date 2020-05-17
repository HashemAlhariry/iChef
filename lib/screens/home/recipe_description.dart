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
  double _sizeOfStepsImage = 150.0;

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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 210,
              floating: false,
              pinned: true,
              backgroundColor: Colors.red[400],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  widget.recipe.name.replaceAll('-', ' '),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                background: _downloadUrl == null
                    ? Container(
                        // width: _sizeOfCirclarImage,
                        // height: _sizeOfCirclarImage,
                        )
                    : InkWell(
                        child: Tooltip(
                          message: "open Image",
                          child:
                              Image.network(_downloadUrl, fit: BoxFit.fitWidth),
                        ),
                        onTap: openImage),
              ),
            ),
          ];
        },
        body: Center(
          child: Center(
            child: ListView(
              children: <Widget>[
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
                  "Duration: " + widget.recipe.duration.toString() + " Min",
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
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Ingredient: ${widget.recipe.ingredients[index].ingredient}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Quantity: ${widget.recipe.ingredients[index].quantity}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Measure: ${widget.recipe.ingredients[index].measure}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
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
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Center(
                              child: Card(
                                margin: EdgeInsets.all(8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: InkWell(
                                  child: Column(
                                    children: <Widget>[
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
                                                  image: new NetworkImage(
                                                      _downloadUrl),
                                                ),
                                              ),
                                            ),
                                      Text(
                                        "Description: " +
                                            widget.recipe.description,
                                        style: TextStyle(fontSize: 14.0),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                      itemCount: widget.recipe.ingredients.length),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openImage() {
    Navigator.of(context).push(
      PageRouteBuilder<Null>(
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget child) {
              return Opacity(
                opacity: animation.value,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.red[400],
                    elevation: 0,
                    title: Text(
                      widget.recipe.name.replaceAll("-", " "),
                    ),
                    leading: CloseButton(),
                  ),
                  body: ListView(children: [
                    Image.network(
                      _downloadUrl,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.center,
                    ),
                  ]),
                ),
              );
            },
          );
        },
        transitionDuration: Duration(milliseconds: 400),
      ),
    );
  }
}
