import 'package:flutter/material.dart';
import 'package:ichef/models/recipe.dart';

class RecipeShape extends StatelessWidget {
  final Recipe recipe;

  RecipeShape({this.recipe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
          color: Colors.pink[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            width: 150,
            height:100,
            child: Container(
             child:  Text(recipe.name ,style: TextStyle(fontSize: 16.0),),
            ),
          )),
    );
  }
}
