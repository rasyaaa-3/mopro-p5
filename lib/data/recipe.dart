// Model: bentuk data 1 resep dari DummyJSON
class Recipe {
  final int id;
  final String name;
  final String image;
  final String cuisine;
  final String difficulty;
  final int cookTimeMinutes;
  final double rating;
  final List<String> ingredients;
  final List<String> instructions;

  Recipe({
    required this.id,
    required this.name,
    required this.image,
    required this.cuisine,
    required this.difficulty,
    required this.cookTimeMinutes,
    required this.rating,
    required this.ingredients,
    required this.instructions,
  });

  // Mengubah JSON (Map) dari API menjadi object Recipe
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      cuisine: json['cuisine'] as String,
      difficulty: json['difficulty'] as String,
      cookTimeMinutes: json['cookTimeMinutes'] as int,
      rating: (json['rating'] as num).toDouble(),
      ingredients: List<String>.from(json['ingredients'] as List),
      instructions: List<String>.from(json['instructions'] as List),
    );
  }
}
