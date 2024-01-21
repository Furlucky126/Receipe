import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Signup with email and password
  Future signup(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return "Success";//Success

    }catch(e){
      return e.toString();//Error message
    }
  }



  //signin with password and email
Future signIn(String email, String password) async {
    try{
     await _auth.signInWithEmailAndPassword(email: email, password: password);
     return "Success";//success
    }
   catch(e){
      return e.toString();//Error message
    }

}

//Sign out
Future signOut() async{
  await _auth.signOut();
  }
}