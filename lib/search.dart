import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _recipes = ["Spaghetti", "Tacos", "Pizza", "Sushi"];
  List<String> _filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    _filteredRecipes = _recipes;
  }

  void _searchRecipes(String query) {
    final filtered = _recipes.where((recipe) {
      final recipeLower = recipe.toLowerCase();
      final queryLower = query.toLowerCase();

      return recipeLower.contains(queryLower);
    }).toList();

    setState(() {
      _filteredRecipes = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by ingredients or food name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _searchRecipes,
            ),
          ),
          Expanded(
            child: _filteredRecipes.isNotEmpty
                ? ListView.builder(
                    itemCount: _filteredRecipes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_filteredRecipes[index]),
                      );
                    },
                  )
                : Center(
                    child: Text('Not available recipes yet.'),
                  ),
          ),
        ],
      ),
    );
  }
}

Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
    getRecipesStartingWith(String letter) async {
  final query = FirebaseFirestore.instance
      .collection('post')
      .where('name', isEqualTo: letter);

  final querySnapshot = await query.get();

  return querySnapshot.docs;
}

void main() => runApp(MaterialApp(home: Search()));
