class Recipe {
  String cuisine;
  String description;
  int duration;
  String image;
  String numberOfServings;
  int price;
  List<Ingredients> ingredients;
  List<Steps> steps;

  Recipe(this.cuisine, this.description, this.duration, this.image,
      this.numberOfServings, this.price, this.ingredients, this.steps);
}

class Ingredients {
  String ingredient;
  double quantity;
  String measure;
  Ingredients(this.ingredient, this.quantity);
}

class Steps {
  String description;
  String image;
  Steps(this.description, this.image);
}
