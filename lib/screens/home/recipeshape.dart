import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ichef/models/recipe.dart';
import 'package:ichef/screens/home/recipe_description.dart';

class RecipeShape extends StatefulWidget {
  final Recipe recipe;

  RecipeShape({this.recipe});

  @override
  _RecipeShapeState createState() => _RecipeShapeState();
}

class _RecipeShapeState extends State<RecipeShape> {
  String _downloadUrl;
  double _sizeOfCirclarImage = 160.0;

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
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecipeDescription(recipe: widget.recipe)),
          );
        },
        child: Column(children: <Widget>[
          _downloadUrl == null
              ? Container(
                  width: _sizeOfCirclarImage,
                  height: _sizeOfCirclarImage,
                )
              : Container(
                  width: _sizeOfCirclarImage,
                  height: _sizeOfCirclarImage,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: new NetworkImage(_downloadUrl)))),
          Text(
            widget.recipe.name,
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            "Price: " + widget.recipe.price.toString(),
            style: TextStyle(fontSize: 14.0),
          )
        ]),
      ),
    );
  }
}
