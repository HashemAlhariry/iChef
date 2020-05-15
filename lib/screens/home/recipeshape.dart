import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ichef/models/recipe.dart';

class RecipeShape extends StatefulWidget {
  final Recipe recipe;

  RecipeShape({this.recipe});

  @override
  _RecipeShapeState createState() => _RecipeShapeState();
}

class _RecipeShapeState extends State<RecipeShape> {
  String _downloadUrl;

  Future downloadImage() async {
    final ref = FirebaseStorage.instance.ref().child(widget.recipe.image);
    String url=await ref.getDownloadURL();
    setState(() {
      _downloadUrl=url;
    });



  }

  @override
  Widget build(BuildContext context) {
    double _sizeOfCirclarImage = 160.0;
    downloadImage();

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000.0),
          ),
          child: Column(children: <Widget>[
            _downloadUrl == null
                ? Container()
                : new Container(
                    width: _sizeOfCirclarImage,
                    height: _sizeOfCirclarImage,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: new NetworkImage(_downloadUrl)))),
            Text(
              widget.recipe.name,
              style: TextStyle(fontSize: 16.0),
            ),

            Text(
              "Price: "+widget.recipe.price.toString(),
              style: TextStyle(fontSize: 14.0),
            )

          ])),
    );
  }
}
