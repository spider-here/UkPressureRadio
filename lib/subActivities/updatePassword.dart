import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:radio/access/forgotPassword.dart';
import 'package:radio/utils/components.dart';


class updatePassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return updatePasswordState();
  }

}

class updatePasswordState extends State{

  components _comp = new components();
  TextEditingController _oldPassController = new TextEditingController();
  TextEditingController _newPassController = new TextEditingController();
  TextEditingController _rePassController = new TextEditingController();
  bool operation = false;
  User? user = FirebaseAuth.instance.currentUser;

  void _changePassword(String currentPassword, String newPassword) async {
    final cred = EmailAuthProvider.credential(
        email: user!.email.toString(), password: currentPassword);

    setState((){
      operation=true;
    });

    user!.reauthenticateWithCredential(cred).then((value) {
      user!.updatePassword(newPassword).then((_) {
        Get.back();
        Get.snackbar("Password Updated", "Password Successfully Reset!",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Theme.of(context).primaryColor,
            overlayBlur: 1.5,
            margin: EdgeInsets.fromLTRB(30.0, MediaQuery.of(context).size.height/3, 30.0, MediaQuery.of(context).size.height/3),
                    colorText: Colors.white,
                    duration: Duration(milliseconds: 3000),
                    animationDuration: Duration(milliseconds: 200));
      }).catchError((error) {
        setState((){
          operation=false;
        });
        Get.snackbar("Error", error.message.toString(),
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red.shade700,
            overlayBlur: 1.5,
            margin: EdgeInsets.fromLTRB(30.0, MediaQuery.of(context).size.height/3, 30.0, MediaQuery.of(context).size.height/3),
                    colorText: Colors.white,
                    duration: Duration(milliseconds: 3000),
                    animationDuration: Duration(milliseconds: 200));
      });
    }).catchError((err) {
      setState((){
        operation=false;
      });
      Get.snackbar("Invalid Old Password", err.message.toString(),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red.shade700,
          overlayBlur: 1.5,
          margin: EdgeInsets.fromLTRB(30.0, MediaQuery.of(context).size.height/3, 30.0, MediaQuery.of(context).size.height/3),
                  colorText: Colors.white,
                  duration: Duration(milliseconds: 3000),
                  animationDuration: Duration(milliseconds: 200));
    });}

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
        title: Text("Update Password", style: TextStyle(color: Colors.black87),),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: EdgeInsets.all(35.0),
        child: Stack(
          children: [
            Align(alignment: FractionalOffset.topCenter,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _comp.loginTextField(
                        context: context,
                        labelText: "Old Password",
                        obscureText: true,
                        icon: ImageIcon(
                            AssetImage('assets/images/password.png')),
                        controller: _oldPassController),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(fontSize: 12.0),
                          ),
                          onTap: () => Get.to(() => forgotPassword(),
                              transition: Transition.rightToLeft),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    _comp.loginTextField(
                        context: context,
                        labelText: "New Password",
                        obscureText: false,
                        icon: ImageIcon(AssetImage('assets/images/password.png')),
                        controller: _newPassController),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    _comp.loginTextField(
                        context: context,
                        labelText: "Retype New Password",
                        obscureText: false,
                        icon: ImageIcon(AssetImage('assets/images/password.png')),
                    controller: _rePassController),
                  ],
                ),
              ),),
            Align(alignment: FractionalOffset.bottomCenter,
            child: Visibility(
              visible: operation,
              child: CircularProgressIndicator(),
            ),),
            Align(alignment: FractionalOffset.bottomCenter,
              child: Visibility(
                visible: !operation,
                child: _comp.mainButton(context: context, label: "Update Password",
                    onPressed: (){
                  if(_newPassController.text==_rePassController.text){
                    _changePassword(_oldPassController.text, _newPassController.text);
                  }
                  else{
                    Get.snackbar("Retype Passwords", "New passwords don't match.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red.shade700,
                        overlayBlur: 1.5,
                        margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: MediaQuery.of(context).size.height/2.5),
                        colorText: Colors.white,
                        duration: Duration(milliseconds: 3000),
                        animationDuration: Duration(milliseconds: 200));
                  }
                    },
                    height: 50.0, width: MediaQuery.of(context).size.width),),
              )
          ],
        ),
      ),
    );
  }

}