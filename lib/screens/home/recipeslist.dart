import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ichef/screens/home/recipeshape.dart';
import 'package:provider/provider.dart';
import 'package:ichef/models/recipe.dart';

class RecipesList extends StatefulWidget {
  @override
  _RecipesListState createState() => _RecipesListState();
}

class _RecipesListState extends State<RecipesList> {

  @override
  Widget build(BuildContext context) {

    final List<Recipe> recipes = new List<Recipe>();

    final allRecipes = Provider.of<QuerySnapshot>(context);
    //print(allRecipes.documents);

    for (var doc in allRecipes.documents) {
      print(doc.data);

      List<Ingredients> ingredients = new List<Ingredients>();
      List<Steps> steps = new List<Steps>();

      for (var ingredient in doc.data['ingredients']) {
        Ingredients ingred = new Ingredients(ingredient['ingredient'], ingredient['quantity']);
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

      //add each recipe in recipesList
      recipes.add(recipe);

    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount:recipes.length,
      itemBuilder: (context,index) {
        return RecipeShape(recipe: recipes[index]);
      },
    );
  }
}
