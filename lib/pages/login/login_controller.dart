// login_controller.dart

import 'package:flutter/material.dart';
import '../../services/authservice.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? _errorText;
  String? get errorText => _errorText;

  Future<void> signIn(BuildContext context) async {
    _errorText = null;
    String result = await AuthService().signIn(emailController.text, passwordController.text);
    if (result == "Success") {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      _errorText = "Invalid email or password";
      print("Failed");
    }
  }
}