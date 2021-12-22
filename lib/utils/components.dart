import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class components{

  Widget loginTextField({required BuildContext context, required String labelText,
    required Widget icon, required TextEditingController controller, required bool obscureText}){
    return TextField(
      obscureText: obscureText,
      controller: controller,
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
          labelText: labelText,
          prefixIcon: icon,
        ),
    );
  }

  Widget mainButton({required BuildContext context, required String label, required onPressed, required double height, required double width}){
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed, child: Text(label),
        style: ButtonStyle(
          shadowColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
            backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)
                )
            )
        ),
      )
    );
  }

  Widget logo(){
    return Image.asset(
      "assets/images/logo.png",
    );
  }

}