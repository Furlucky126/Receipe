import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class MyListScreen extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('Post').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<DocumentSnapshot> documents = snapshot.data!.docs;
            return documents.isEmpty 
              ? Center(child: Text("Empty Data"))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, // Set the number of columns you want
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
                      return RecipeCard(
                        imageurl: data["imageURL"],
                        content: data["content"],
                        recipe: Recipe(
                          name: data["name"] ?? '',
                          description: data["description"],
                          imagePath: data["imagePath"],
                          likes: data["likes"],
                          saved: data["saved"],
                          userProfileImage: data["userProfileImage"],
                          userName: data["userName"],
                        ),
                      );
                    },
                  ),
                );
          }
        },
      ),
    );
  }
}
