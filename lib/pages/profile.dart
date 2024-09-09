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
                  'https://scontent.fktm14-1.fna.fbcdn.net/v/t39.30808-6/358427942_1505305030274494_5771678048894344973_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=tHK0nqdCZ-0Q7kNvgGtki97&_nc_ht=scontent.fktm14-1.fna&_nc_gid=A5ZepVxa8QsvhgzQ4sbs7gq&oh=00_AYAmui_lcbmOUjowHHx2uvlPmAvVxvezOTxX-JTBqxYCbA&oe=66E505B7'),
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
            const SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Column(
                children: [
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
                        // Navigator.pushNamed(context, '/change_password');
                        // Navigate to change password page
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
