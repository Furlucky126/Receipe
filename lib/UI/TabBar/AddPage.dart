
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {
  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;

  final TextEditingController _contentController = TextEditingController();

  //firestore initialization
  FirebaseFirestore firestore = FirebaseFirestore.instance;

/* firebase storage reference initialized  */
  Reference storageReference = FirebaseStorage.instance
      .ref()
      .child('postImage');


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Add Page'),
          SizedBox(height:8),
          if (_selectedImage != null)
            Image.file(
              _selectedImage!,
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Pick Image'),
          ),
          // Image.asset(
          //   'assets/5.jpg',
          //   height: 250,
          //   width: 300,
          //   fit: BoxFit.cover,
          //
          // ),
          SizedBox(height: 35),
          Container(
            height: 100,
            width: 300,
            child: TextField(
              controller: _contentController,
              decoration: InputDecoration(
                hintText: 'Enter your feedback...',
                labelText: 'Feedback',
                border: OutlineInputBorder(),
              ),
              maxLines: 5, // You can adjust the number of lines based on your design
            ),
          ),  SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // addDataToFirebase();
              uploadImageToFirebaseStorage(_selectedImage!);
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  Future<void> uploadImageToFirebaseStorage(
      File imagePath) async {
    try {



      var uploadTask = storageReference.child('${DateTime.now()}.jpg').putFile(imagePath);

      String downloadURL =
      await (await uploadTask).ref.getDownloadURL();

      await firestore.collection('Post').add({
        'imageURL': downloadURL,
        'content': _contentController.text.trim()
      });

      print('Image uploaded and URL saved to Fire store successfully.');
    } catch (error) {
      print('Error uploading image or saving URL to Fire store: $error');
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 65);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }
}