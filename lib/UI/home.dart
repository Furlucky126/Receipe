import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:receipebook/UI/receipedetail.dart';
import 'package:receipebook/UI/services/MyListScreen.dart';
import 'package:receipebook/pages/profile.dart';
import 'package:receipebook/search.dart';
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
      appBar: AppBar(title: Text("DishDash")),
      body: _getPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.black), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add, color: Colors.black), label: 'Add'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.black), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return MyListScreen();
      case 1:
        return Search();
      case 2:
        return AddPage();
      case 3:
        return ProfilePage(
            username: 'lucky Sherpa',
            profileImageUrl: '',
            email: 'user@example.com');
      default:
        return MyListScreen();
    }
  }
}

class Recipe {
  final String name;
  final String description;
  final String imagePath;
  final int likes;
  final bool saved;
  final String userProfileImage;
  final String userName;

  Recipe({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.likes,
    required this.saved,
    required this.userProfileImage,
    required this.userName,
  });
}

class RecipeCard extends StatefulWidget {
  final String? imageurl;
  final String? content;
  final Recipe? recipe;

  const RecipeCard({this.imageurl, this.content, this.recipe});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  bool isLiked = false;
  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    print(widget.content);

    return InkWell(
      splashColor: Colors.red,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Receipedetail(
              content: widget.content ?? 'no content',
              imagePath: widget.imageurl!,
              title: widget.recipe!.description),
        ));
      },
      child: Card(
        // margin: const EdgeInsets.all(8),
        elevation: 3,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: widget.recipe?.userProfileImage != null &&
                          widget.recipe!.userProfileImage.isNotEmpty
                      ? NetworkImage(widget.recipe!.userProfileImage)
                      : AssetImage('assets/1.jpg') as ImageProvider,
                ),
                title: Text(widget.recipe?.userName ?? 'Unknown User',
                    overflow: TextOverflow.ellipsis),
              ),
              if (widget.imageurl != null && widget.imageurl!.isNotEmpty)
                Image.network(
                  widget.imageurl!,
                  height: MediaQuery.sizeOf(context).height * 0.38,
                  fit: BoxFit.cover,
                )
              else
                Container(
                  height: 120,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Text(
                      'No Image Available',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.recipe?.name ?? 'No Recipe Name',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  widget.recipe?.description ?? 'No Description Available',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    // flex: 3\,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                      label: Text(
                        'Like',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isLiked ? Colors.orange : Colors.black),
                      ),
                      icon: Icon(
                        Icons.thumb_up,
                        color: isLiked ? Colors.orange : Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          isSaved = !isSaved;
                        });
                      },
                      label: Text(
                        'Save',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSaved ? Colors.deepPurple : Colors.black),
                      ),
                      icon: Icon(
                        Icons.bookmark,
                        color: isSaved ? Colors.deepPurple : Colors.black,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

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
                ? const Center(child: Text("Empty Data"))
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.8, // Adjust this value as needed
                      ),
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data =
                            documents[index].data() as Map<String, dynamic>;
                        // print(data.entries);
                        return InkWell(
                          splashColor: Colors.orange,
                          onTap: () {},
                          child: RecipeCard(
                            imageurl: data["imageURL"] as String?,
                            content: data["title"] as String?,
                            recipe: Recipe(
                              name: data["title"] ?? 'No Namee',
                              description: data["content"] ?? 'No description',
                              imagePath: data["imagePath"] ?? '',
                              likes: data["likes"] ?? 0,
                              saved: data["saved"] ?? false,
                              userProfileImage: data["userProfileImage"] ?? '',
                              userName: data["userName"] ?? 'Anonymous',
                            ),
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
