import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mopro_p5/data/recipe.dart';
import 'package:mopro_p5/pages/recipe_detail.dart';
import 'package:mopro_p5/widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  final int limit = 10; // jumlah resep per halaman
  List<Recipe> recipes = []; // resep yang sedang ditampilkan
  int page = 1;
  int total = 0; // total resep di server
  String query = ''; // kata kunci pencarian (kosong = tampilkan semua)
  bool loading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Satu fungsi untuk memanggil 2 endpoint:
  //  - query kosong  -> ENDPOINT 1: GET /recipes
  //  - query terisi  -> ENDPOINT 2: GET /recipes/search?q=...
  Future<void> _loadRecipes() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final skip = limit * (page - 1);
      final Uri url;

      if (query.isEmpty) {
        url = Uri.https('dummyjson.com', '/recipes', {
          'limit': '$limit',
          'skip': '$skip',
        });
      } else {
        url = Uri.https('dummyjson.com', '/recipes/search', {
          'q': query,
          'limit': '$limit',
          'skip': '$skip',
        });
      }

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Exception('Kode error ${response.statusCode}');
      }

      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final list = (body['recipes'] as List)
          .map((item) => Recipe.fromJson(item as Map<String, dynamic>))
          .toList();

      if (!mounted) return;
      setState(() {
        recipes = list;
        total = body['total'] as int;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        error = 'Gagal memuat resep. Cek koneksi internet lu.';
        loading = false;
      });
    }
  }

  void _search() {
    query = _searchController.text.trim();
    page = 1; // balik ke halaman pertama tiap pencarian baru
    _loadRecipes();
  }

  int get totalPages {
    final pages = (total / limit).ceil();
    return pages < 1 ? 1 : pages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Resep Masakan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _search(),
              decoration: InputDecoration(
                hintText: 'Cari resep (contoh: pizza)...',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _search,
                ),
              ),
            ),
          ),
          Expanded(child: _buildBody()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: (page > 1 && !loading)
                      ? () {
                          page--;
                          _loadRecipes();
                        }
                      : null,
                  icon: const Icon(Icons.chevron_left),
                  label: const Text('Previous'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('$page / $totalPages'),
                ),
                ElevatedButton.icon(
                  onPressed: (page < totalPages && !loading)
                      ? () {
                          page++;
                          _loadRecipes();
                        }
                      : null,
                  icon: const Icon(Icons.chevron_right),
                  label: const Text('Next'),
                  iconAlignment: IconAlignment.end,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Menentukan isi layar: loading, error, kosong, atau daftar resep
  Widget _buildBody() {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _loadRecipes,
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      );
    }

    if (recipes.isEmpty) {
      return const Center(child: Text('Resep tidak ditemukan'));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return RecipeCard(
          recipe: recipe,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RecipeDetail(recipe: recipe),
              ),
            );
          },
        );
      },
    );
  }
}
