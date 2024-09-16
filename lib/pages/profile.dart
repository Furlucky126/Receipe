import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:receipebook/pages/login/login_view.dart';

class ProfilePage extends StatelessWidget {
  final String username;
  final String email;
  final String profileImageUrl;

  const ProfilePage({
    Key? key,
    required this.username,
    required this.email,
    required this.profileImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', textAlign: TextAlign.center),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://i.redd.it/i-got-bored-so-i-decided-to-draw-a-random-image-on-the-v0-4ig97vv85vjb1.png?width=1280&format=png&auto=webp&s=7177756d1f393b6e093596d06e1ba539f723264b'),
            ),
            const SizedBox(height: 20),
            Text(
              username,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              email,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                  // Card(
                  //   elevation: 4,
                  //   margin: const EdgeInsets.symmetric(vertical: 8),
                  //   child: ListTile(
                  //     leading: const Icon(Icons.edit),
                  //     title: const Text('Edit Profile'),
                  //     onTap: () {
                  //       // Navigate to edit profile page
                  //     },
                  //   ),
                  // ),
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.lock),
                      title: const Text('Change Password'),
                      onTap: () async {
                        // Navigator.pushNamed(context, '/change_password');
                        // Navigate to change password page
                        await forgotPassword(
                            email: FirebaseAuth.instance.currentUser!.email!);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginView()),
                      );
                      // Add logout functionality here
                      print('Logout pressed');
                    },
                    child: Text('Logout'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future forgotPassword({required String email}) async {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  try {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  } on FirebaseAuthException catch (err) {
    throw Exception(err.message.toString());
  } catch (err) {
    throw Exception(err.toString());
  }
}
