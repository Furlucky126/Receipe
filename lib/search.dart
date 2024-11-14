import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredRecipes = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchRecipes(""); // Optionally, fetch all recipes initially.
  }

  Future<void> _searchRecipes(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('post')
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      setState(() {
        _filteredRecipes = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      print("Error searching recipes: $e");
      setState(() {
        _filteredRecipes = [];
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Recipes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by food name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                _searchRecipes(query); // Search when text changes.
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _filteredRecipes.isNotEmpty
                    ? ListView.builder(
                        itemCount: _filteredRecipes.length,
                        itemBuilder: (context, index) {
                          final recipe = _filteredRecipes[index];
                          return ListTile(
                            leading: recipe['imageUrl'] != null
                                ? Image.network(recipe['imageUrl'], width: 50, height: 50)
                                : Icon(Icons.fastfood),
                            title: Text(recipe['title']),
                            subtitle: Text(recipe['content'] ?? 'No description'),
                            trailing: Icon(
                              recipe['isLike'] ? Icons.favorite : Icons.favorite_border,
                              color: recipe['isLike'] ? Colors.red : null,
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text('No recipes found.'),
                      ),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: Search()));
