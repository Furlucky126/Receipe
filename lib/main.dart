import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:receipebook/UI/home.dart' as Home;
import 'package:receipebook/pages/login/login_view.dart';
import 'package:receipebook/pages/signup/signup_view.dart';
import 'pages/FormPage.dart';
import 'UI/services/MyListScreen.dart';
import 'package:geolocator/geolocator.dart';

late final FirebaseApp app;
late final FirebaseAuth auth;
Position? pos;

Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp();
  auth = FirebaseAuth.instanceFor(app: app);

  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  pos = await Geolocator.getCurrentPosition();


  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginView(),
    routes: {
      'register': (context) => const SignUpView(),
      'login': (context) => const LoginView(),
      'home': (context) => Home.HomePage(),
       // Use the prefix for HomePage
    },
  ));
}
