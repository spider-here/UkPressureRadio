import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:radio/utils/components.dart';


class forgotPassword extends StatelessWidget {
  components _comp = new components();
  TextEditingController _emailController = new TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  sendResetEmail(BuildContext context) async {
    try{
      await _auth.sendPasswordResetEmail(email: _emailController.text).then((value) => Get.snackbar("Email Sent", "Please check your email to reset your password.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Theme.of(context).primaryColor,
          overlayBlur: 1.5,
          margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: MediaQuery.of(context).size.height/2.5),
          colorText: Colors.white,
          duration: Duration(milliseconds: 3000),
          animationDuration: Duration(milliseconds: 200)));
    }
    on FirebaseAuthException catch(e){
      Get.snackbar("Error", e.message.toString(),
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
          iconTheme: IconThemeData(
              color: Colors.black87
          ),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Forgot Password?", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                        Spacer(),
                        Text("Enter Email for Verification Code", style: TextStyle(fontSize: 12.0,)),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                        ),
                        _comp.loginTextField(
                            context: context,
                            obscureText: false,
                            labelText: "Email",
                            icon: ImageIcon(AssetImage('assets/images/user.png')),
                        controller: _emailController),
                        Spacer(),
                      ],
                    )),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _comp.mainButton(
                            context: context,
                            label: "SEND CODE",
                            onPressed: ()=>sendResetEmail(context),
                            height: 50.0,
                            width: MediaQuery.of(context).size.width),
                      ],
                    )),
              ),
            ]),
          ),
        ));
  }
}
