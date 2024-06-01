import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:receipebook/UI/MyListScreen.dart';

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
        return ProfilePage();
      default:
        return RecipeList(); // Default to the home page
    }
  }
}



class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: Container(

      margin: EdgeInsets.only(top: 40),
              height: 120,
              width: 120,
              child: CircleAvatar(
                backgroundImage: NetworkImage('https://scontent.fktm9-2.fna.fbcdn.net/v/t39.30808-1/358427942_1505305030274494_5771678048894344973_n.jpg?stp=dst-jpg_p200x200&_nc_cat=104&ccb=1-7&_nc_sid=5740b7&_nc_ohc=YbJfX_V0bLwAX-pjwmW&_nc_ht=scontent.fktm9-2.fna&oh=00_AfBFIlcl7XoIr99qFnK-pbw4jyil4bs0g483486hdGRSrA&oe=65B7A8B5'),
              ),
            ),
          ),
          const Padding(

            padding:  EdgeInsets.all(8.0),
            child: SizedBox(
              child: Text('Lucky Sherpa', style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text('Follow Me',style: TextStyle(
            fontSize: 25
          ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.facebook, size: 40,),),
              IconButton(onPressed: (){}, icon: Icon(Icons.snapchat, size: 40,)),
            ],
          )
        ],
      ),
    );
  }
}




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
    description: 'Classic Italian pasta dish Heat olive oil and soften onion, carrots, and celery. Add garlic and browned ground beef, then simmer in red wine (optional), crushed tomatoes, tomato paste, herbs, and spices. Let simmer for at least 30 minutes, toss with cooked spaghetti, and garnish with parsley and Parmesan. Enjoy!',
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

  const RecipeCard({ this.imageurl, this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: EdgeInsets.all(16),
      elevation: 3,
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              imageurl,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                content,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
