import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:radio/access/login.dart';
import 'package:radio/subActivities/editProfile.dart';
import 'package:radio/utils/components.dart';

class settings extends StatelessWidget {

  components _comp = new components();

  FirebaseAuth _auth = FirebaseAuth.instance;

  signOut() async {
    try {
      await _auth.signOut().whenComplete(() => Get.offAll(()=>login()));
    } on FirebaseAuthException catch(e) {
      return e.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).backgroundColor,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: EdgeInsets.fromLTRB(35.0, 10, 35, 35),
        child: Stack(
          children: [
            Align(
              alignment: FractionalOffset.topCenter,
              child: Container(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Edit Profile",
                      ),
                      trailing: Icon(
                        Icons.navigate_next_rounded,
                        color: Colors.black87,
                      ),
                      onTap: () => Get.to(() => editProfile(),
                          transition: Transition.rightToLeft),
                    ),
                    ListTile(
                      title: Text(
                        "About Us",
                      ),
                      trailing: Icon(
                        Icons.navigate_next_rounded,
                        color: Colors.black87,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: _comp.mainButton(
                  context: context,
                  label: "LOGOUT",
                  onPressed: () => signOut(),
                  height: 50.0,
                  width: MediaQuery.of(context).size.width),
            ),
          ],
        ),
      ),
    );
  }
}
