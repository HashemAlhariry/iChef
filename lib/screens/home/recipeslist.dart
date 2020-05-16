import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ichef/screens/home/recipeshape.dart';
import 'package:ichef/models/recipe.dart';
import 'package:ichef/services/database.dart';

class RecipesList extends StatefulWidget {
  @override
  _RecipesListState createState() => _RecipesListState();
}

class _RecipesListState extends State<RecipesList> {
  final DatabaseService _database = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _database.recipesCollection.snapshots(),
      builder: (cont, snapshot) {
        if (snapshot.hasData) {
          List<RecipeShape> recipes = List();
          for (var doc in snapshot.data.documents) {
            List<Ingredients> ingredients = new List<Ingredients>();
            List<Steps> steps = new List<Steps>();

            for (var ingredient in doc.data['ingredients']) {
              Ingredients ingred = new Ingredients(
                  ingredient['ingredient'], ingredient['quantity']);
              ingredients.add(ingred);
            }

            for (var step in doc.data['steps']) {
              Steps ste = new Steps(step['description'], step['image']);
              steps.add(ste);
            }

            Recipe recipe = new Recipe(
                doc.data['name'],
                doc.data['cuisine'],
                doc.data['description'],
                doc.data['duration'],
                doc.data['image'],
                doc.data['numberOfServings'],
                doc.data['price'],
                ingredients,
                steps);

            recipes.add(RecipeShape(recipe: recipe));
          }
          return SliverList(
            delegate: SliverChildListDelegate(recipes),
          );
        }
        return SliverToBoxAdapter(
          child: Container(),
        );
      },
    );
  }
}
