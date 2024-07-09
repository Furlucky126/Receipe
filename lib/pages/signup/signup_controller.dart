// signup_controller.dart

import 'package:flutter/material.dart';
import 'package:receipebook/services/authservice.dart';

class SignUpController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signUp(BuildContext context) async {
    String result = await AuthService().signup(emailController.text, passwordController.text);
    if (result == "Success") {
      Navigator.pushReplacementNamed(context, 'login');
    } else {
      print("Failed");
      // You might want to show an error message to the user here
    }
  }
}