import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class video extends StatelessWidget{
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
        title: Text("Video", style: TextStyle(color: Colors.black87),),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: ListView.builder(itemBuilder: (BuildContext context, int index){
          return Container(
            margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/4,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.cover
                )
            ),
            child: Stack(
              children: [
                Align(alignment: FractionalOffset.center,
                  child: ImageIcon(AssetImage("assets/images/play.png",), color: Colors.white, size: 50.0,),),
              ],
            ),
          );
        },
          itemCount: 8,),
      ),
    );
  }

}