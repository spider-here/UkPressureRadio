import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:radio/subActivities/updatePassword.dart';
import 'package:radio/utils/components.dart';


class editProfile extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return editProfileState();
  }

}

class editProfileState extends State{


  components _comp = new components();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  bool operation = false;

  
  User? _currentUser = FirebaseAuth.instance.currentUser;
  String _email = FirebaseAuth.instance.currentUser!.email.toString();
  String userName="";
  DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("Users");
  getUsername() async{
    await dbRef.child(_currentUser!.uid).child("Username").once().then((DataSnapshot snapshot){
      userName = snapshot.value.toString();
    }).whenComplete(() => setState((){_nameController.text=userName;}));
  }

  ///********* reset email temporarily removed on request
  ///
  // _resetEmail(String newEmail, BuildContext context) async {
  //   setState(() {
  //     operation = true;
  //   });
  //   _currentUser!
  //       .updateEmail(newEmail).whenComplete(() {
  //     setState(() {
  //       operation = false;
  //     });
  //     Get.offAll(login());
  //     Get.snackbar(
  //         "Email Updated", "Please sign in with your new email account",
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Theme
  //             .of(context)
  //             .primaryColor,
  //         overlayBlur: 1.5,
  //         margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: MediaQuery.of(context).size.height/2.5),
  //         colorText: Colors.white,
  //         duration: Duration(milliseconds: 3000),
  //         animationDuration: Duration(milliseconds: 200));
  //   }).catchError((error) {
  //     setState(() {
  //       operation = false;
  //     });
  //     Get.snackbar("Error", error.message.toString(),
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red.shade700,
  //         overlayBlur: 1.5,
  //         margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: MediaQuery.of(context).size.height/2.5),
  //         colorText: Colors.white,
  //         duration: Duration(milliseconds: 3000),
  //         animationDuration: Duration(milliseconds: 200));
  //   });
  // }

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
        title: Text("Edit Profile", style: TextStyle(color: Colors.black87),),
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
                        labelText: "Username",
                        obscureText: false,
                        icon: ImageIcon(AssetImage('assets/images/user.png')),
                    controller: _nameController),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),

                    //////******** Showing disabled email text field as reset option is removed on request.

                    // _comp.loginTextField(
                    //     context: context,
                    //     labelText: "Email",
                    //     obscureText: false,
                    //     icon: ImageIcon(AssetImage('assets/images/user.png')),
                    // controller: _emailController),

                    TextField(
                      readOnly: true,
                      controller: _emailController,
                      style: TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 1.0
                              ),
                              borderRadius: BorderRadius.all(Radius.zero)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.0
                              ),
                              borderRadius: BorderRadius.all(Radius.zero)
                          ),
                          labelText: "Email",
                          prefixIcon: ImageIcon(AssetImage('assets/images/user.png')),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    TextField(
                      obscureText: true,
                      readOnly: true,
                      onTap: ()=>Get.defaultDialog(title: "Change Password?",
                      content: Text("Are you sure you want to change your existing password?", textAlign: TextAlign.center,),
                      textConfirm: "Yes",
                      textCancel: "No",
                        onConfirm: ()=>Get.to(()=>updatePassword())
                      ),
                      controller: _passController,
                      decoration: InputDecoration(
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black87,
                                width: 1.0
                            ),
                            borderRadius: BorderRadius.all(Radius.zero)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1.0
                            ),
                            borderRadius: BorderRadius.all(Radius.zero)
                        ),
                        labelText: "Password",
                        prefixIcon: ImageIcon(AssetImage('assets/images/password.png')),
                        suffixIcon: Icon(Icons.edit_rounded)
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0),
                    ),
                  ],
                ),
              ),),Align(alignment: FractionalOffset.bottomCenter,
        child: Visibility(
          visible: operation,
          child: CircularProgressIndicator(),
        ),),
        Align(alignment: FractionalOffset.bottomCenter,
          child: Visibility(
            visible: !operation,
            child: _comp.mainButton(context: context, label: "Update Profile", onPressed: (){

              //////******* Condition on name only as Email reset removed on request.

                // if(_emailController.text!=_email && _nameController.text!=userName){
                //   dbRef.child(_currentUser!.uid).child("Username").set(_nameController.text);
                //   _resetEmail(_emailController.text, context);
                // }
                // else if(_emailController.text==_email && _nameController.text!=userName){
                //   dbRef.child(_currentUser!.uid).child("Username").set(_nameController.text)
                //       .whenComplete(() => Get.snackbar(
                //       "Profile Updated", "Username updated successfully!",
                //       snackPosition: SnackPosition.BOTTOM,
                //       backgroundColor: Theme
                //           .of(context)
                //           .primaryColor,
                //       overlayBlur: 1.5,
                //       margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: MediaQuery.of(context).size.height/2.5),
                //       colorText: Colors.white,
                //       duration: Duration(milliseconds: 3000),
                //       animationDuration: Duration(milliseconds: 200)));
                //
                // }
                // else if(_emailController.text!=_email && _nameController.text==userName){
                //   _resetEmail(_emailController.text, context);
                // }
                // else{
                //   Get.back();
                // }

              if(_nameController.text!=userName){
              dbRef.child(_currentUser!.uid).child("Username").set(_nameController.text)
                  .whenComplete(() => Get.snackbar(
              "Profile Updated", "Username updated successfully!",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Theme
                  .of(context)
                  .primaryColor,
              overlayBlur: 1.5,
              margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: MediaQuery.of(context).size.height/2.5),
              colorText: Colors.white,
              duration: Duration(milliseconds: 3000),
              animationDuration: Duration(milliseconds: 200)));

              }
              else{
              Get.back();
              }
              },
                  height: 50.0, width: MediaQuery.of(context).size.width),),)
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getUsername();
    _nameController.text=userName;
    _emailController.text=_email;
    _passController.text="******";
  }
}