import 'package:flutter_test/flutter_test.dart';
import 'package:mopro_p5/data/recipe.dart';

void main() {
  test('Recipe.fromJson membaca data dengan benar', () {
    final r = Recipe.fromJson({
      'id': 1,
      'name': 'Pizza Margherita',
      'image': 'https://example.com/pizza.jpg',
      'cuisine': 'Italian',
      'difficulty': 'Easy',
      'cookTimeMinutes': 15,
      'rating': 4.6,
      'ingredients': ['Tepung', 'Keju'],
      'instructions': ['Campur', 'Panggang'],
    });

    expect(r.name, 'Pizza Margherita');
    expect(r.cookTimeMinutes, 15);
    expect(r.ingredients.length, 2);
  });
}
