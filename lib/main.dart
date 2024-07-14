import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:receipebook/UI/TabBar/AddPage.dart';
import 'package:receipebook/UI/home.dart' as Home;
import 'package:receipebook/editprofile.dart';
import 'package:receipebook/pages/login/login_view.dart';
import 'package:receipebook/pages/profile.dart';
import 'package:receipebook/pages/signup/signup_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:receipebook/search.dart';
import 'package:receipebook/splashscreen.dart';


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
    home: const LoginView(),
    routes: {
      'register': (context) => const SignUpView(),
      'login': (context) => const LoginView(),
      'home': (context) => const Home.HomePage(),
      'screen': (context) => const Search(),
      'splashscreen': (context) => const Splashscreen(),
      'editprofile': (context) => const EditProfile(),
      'search': (context) => Search(),
      'add': (context) => AddPage(),
      
       // Use the prefix for HomePage
    },
  ));

}
