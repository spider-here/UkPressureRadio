import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:radio/utils/components.dart';
import 'package:firebase_database/firebase_database.dart';

import 'login.dart';

class signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return signupState();
  }
}

class signupState extends State {
  components _comp = new components();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  var dbRef = FirebaseDatabase.instance.reference();
  bool operation = false;

  signUp({required String username, required String email, required String password}) async {
    setState(() {
      operation = true;
    });
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password,)
          .then((value) {
        setState(() {
          operation = false;
        });
      });
      dbRef.child("Users").child(_auth.currentUser!.uid).child("uid").set(_auth.currentUser!.uid.toString());
      dbRef.child("Users").child(_auth.currentUser!.uid).child("Username").set(_nameController.text.toString());
      _auth.signOut();
      Get.back();
      Get.snackbar("Great!", "Now Login to Continue",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Theme.of(context).primaryColor,
          overlayBlur: 1.5,
          margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: MediaQuery.of(context).size.height/2.5),
          colorText: Colors.white,
          duration: Duration(milliseconds: 3000),
          animationDuration: Duration(milliseconds: 200));
    } on FirebaseAuthException catch (e) {
      setState(() {
        operation = false;
      });
      Get.snackbar("Invalid Credentials", e.message.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade700,
          overlayBlur: 1.5,
          margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: MediaQuery.of(context).size.height/2.5),
          colorText: Colors.white,
          duration: Duration(milliseconds: 3000),
          animationDuration: Duration(milliseconds: 200));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black87),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).backgroundColor,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height / 1.15,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(35.0, 10, 35, 35),
            child: Stack(children: [
              Align(
                  alignment: FractionalOffset.topCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    child: _comp.logo(),
                  )),
              Align(
                alignment: FractionalOffset.center,
                child: Container(
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _comp.loginTextField(
                            context: context,
                            obscureText: false,
                            labelText: "Username",
                            icon:
                                ImageIcon(AssetImage('assets/images/user.png')),
                            controller: _nameController),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                        ),
                        _comp.loginTextField(
                            context: context,
                            labelText: "Email",
                            obscureText: false,
                            icon:
                                ImageIcon(AssetImage('assets/images/user.png')),
                            controller: _emailController),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                        ),
                        _comp.loginTextField(
                            context: context,
                            labelText: "Password",
                            obscureText: true,
                            icon: ImageIcon(
                                AssetImage('assets/images/password.png')),
                            controller: _passController),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                        ),
                      ],
                    )),
              ),
              Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Visibility(
                    visible: !operation,
                    child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _comp.mainButton(
                                context: context,
                                label: "SIGN UP",
                                onPressed: () => _nameController.text.length>3?signUp(
                                  username: _nameController.text,
                                    email: _emailController.text,
                                    password: _passController.text): Get.snackbar("Invalid Username", "Username too short!",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red.shade700,
                                    overlayBlur: 1.5,
                                    margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: MediaQuery.of(context).size.height/2.5),
                                    colorText: Colors.white,
                                    duration: Duration(milliseconds: 3000),
                                    animationDuration: Duration(milliseconds: 200)),
                                height: 50.0,
                                width: MediaQuery.of(context).size.width),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                            ),
                            InkWell(
                              onTap: () => Get.back(),
                              child: Text("Already have an account? Sign In"),
                            )
                          ],
                        )),
                  )),
              Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Visibility(
                    visible: operation,
                    child: CircularProgressIndicator(),
                  ))
            ]),
          ),
        ));
  }
}
