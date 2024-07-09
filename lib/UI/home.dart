import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:receipebook/UI/services/MyListScreen.dart';
import 'package:receipebook/pages/profile.dart';

import 'TabBar/AddPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to Recipe Book"),
      ),
      body: _getPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return MyListScreen();
      case 1:
        return AddPage();
      case 2:
        return ProfilePage(username: '', profileImageUrl: '', email: '',);
      default:
        return RecipeList(); // Default to the home page
    }
  }
}

// class ProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Profile Page'),
//     );
//   }
// }

class RecipeList extends StatelessWidget {
  const RecipeList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        // return RecipeCard(recipe: recipes[index]);
      },
    );
  }
}

class Recipe {
  final String name;
  final String description;
  final String imagePath;

  Recipe({
    required this.name,
    required this.description,
    required this.imagePath,
  });
}

final List<Recipe> recipes = [
  Recipe(
    name: 'Spaghetti Bolognese',
    description: 'Classic Italian pasta dish',
    imagePath: 'assets/1.jpg',
  ),
  Recipe(
    name: 'Chicken Alfredo',
    description: 'Creamy pasta with grilled chicken',
    imagePath: 'assets/2.jpg',
  ),
  Recipe(
    name: 'Vegetable Stir-Fry',
    description: 'Healthy and delicious stir-fried veggies',
    imagePath: 'assets/3.jpg',
  ),

  Recipe(
    name: 'Kabuli Pulau',
    description: 'light and aromatic rice dish with lamb',
    imagePath: 'assets/4.jpg',
  ),
  // Add more recipes as needed
];

class RecipeCard extends StatelessWidget {
  final imageurl, content;

  const RecipeCard({this.imageurl, this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: EdgeInsets.all(16),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          imageurl != null
              ? Image.network(
                  imageurl,
                  height: 200,
                  fit: BoxFit.cover,
                )
              : Padding(
                  padding: EdgeInsets.all(7),
                  child: Text(
                    content ?? 'No content available',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
        ],
      ),
    );
  }
}
