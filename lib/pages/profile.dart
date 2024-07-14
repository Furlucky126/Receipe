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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(profileImageUrl),
            ),
            SizedBox(height: 20),
            Text(
              username,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              email,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
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
            const SizedBox(height: 24),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Profile'),
                onTap: () {
                  // Navigate to edit profile page
                },
              ),
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Change Password'),
                onTap: () {
                  Navigator.pushNamed(context, '/change_password');
                  // Navigate to change password page
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
