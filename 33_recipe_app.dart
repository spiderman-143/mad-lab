import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const RecipeApp());

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.orange),
      home: const RecipeHome(),
    );
  }
}

class RecipeHome extends StatefulWidget {
  const RecipeHome({super.key});

  @override
  State<RecipeHome> createState() => _RecipeHomeState();
}

class _RecipeHomeState extends State<RecipeHome> {
  final controller = TextEditingController(text: 'chicken');
  List<dynamic> meals = [];

  Future<void> searchRecipes() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.themealdb.com/api/json/v1/1/search.php?s=${Uri.encodeComponent(controller.text)}'));
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      meals = (data['meals'] ?? []) as List<dynamic>;
    } catch (_) {
      meals = [];
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    searchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe App')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(controller: controller, decoration: const InputDecoration(labelText: 'Search recipe')),
                ),
                const SizedBox(width: 10),
                FilledButton(onPressed: searchRecipes, child: const Text('Search')),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: meals.length,
                itemBuilder: (context, index) {
                  final meal = meals[index] as Map<String, dynamic>;
                  return Card(
                    child: ListTile(
                      leading: Image.network('${meal['strMealThumb']}', width: 50, fit: BoxFit.cover),
                      title: Text('${meal['strMeal']}'),
                      subtitle: Text('${meal['strArea']}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
