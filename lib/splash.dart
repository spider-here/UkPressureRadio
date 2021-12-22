import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'access/login.dart';
import 'home/home.dart';

class splash extends StatelessWidget {
  User? _currentUser;


  splash(this._currentUser);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: Image.asset("assets/images/logo.png"),
        nextScreen: _currentUser!=null?home():login(),
        splashTransition: SplashTransition.fadeTransition,
        splashIconSize: MediaQuery.of(context).size.width / 2,
        centered: true,
        animationDuration: Duration(milliseconds: 600),
        duration: _currentUser!=null?600:1500,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}
