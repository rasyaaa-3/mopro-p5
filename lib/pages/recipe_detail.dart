import 'package:flutter/material.dart';
import 'package:mopro_p5/data/recipe.dart';

class RecipeDetail extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetail({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        title: Text(recipe.name),
      ),
      body: ListView(
        children: [
          Image.network(
            recipe.image,
            height: 220,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const SizedBox(
              height: 220,
              child: Icon(Icons.restaurant, size: 60),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${recipe.cuisine} • ${recipe.difficulty} • '
                  '${recipe.cookTimeMinutes} menit • ⭐ ${recipe.rating}',
                ),
                const SizedBox(height: 20),
                const Text(
                  'Bahan-bahan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                for (final bahan in recipe.ingredients) Text('• $bahan'),
                const SizedBox(height: 20),
                const Text(
                  'Langkah-langkah',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                for (int i = 0; i < recipe.instructions.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text('${i + 1}. ${recipe.instructions[i]}'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
