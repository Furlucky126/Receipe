import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final fullNameController = TextEditingController();
  final PhoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: fullNameController,
            decoration: const InputDecoration(
              hintText: 'Full Name',

            ),
          ),
          TextField(
            controller: PhoneController,
            decoration: const InputDecoration(
              hintText: 'Full Name',

            ),
          ),
          ElevatedButton(onPressed: (){}, child: const Text('Save changes'))
        ],
      ),

    );
  }
}