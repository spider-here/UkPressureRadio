import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radio/splash.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  User? _currentUser = FirebaseAuth.instance.currentUser;
  runApp(GetMaterialApp(
    home: splash(_currentUser),
    theme: ThemeData(
      fontFamily: 'Quicksand',
      backgroundColor: Colors.white,
      primaryColor: Color(0xFF05232D),
      primarySwatch: appPrimary
    ),
  ));
}
  MaterialColor appPrimary = MaterialColor(0xFF05232D, <int, Color>{
  50: Color.fromRGBO(5, 35, 45, 1),
  100: Color.fromRGBO(5, 35, 45, 1),
  200: Color.fromRGBO(5, 35, 45, 1),
  300: Color.fromRGBO(5, 35, 45, 1),
  400: Color.fromRGBO(5, 35, 45, 1),
  500: Color.fromRGBO(5, 35, 45, 1),
  600: Color.fromRGBO(5, 35, 45, 1),
  700: Color.fromRGBO(5, 35, 45, 1),
  800: Color.fromRGBO(5, 35, 45, 1),
  900: Color.fromRGBO(5, 35, 45, 1),
  });

