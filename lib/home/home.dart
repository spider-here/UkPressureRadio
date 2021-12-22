
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homeScreens/radio.dart';
import 'homeScreens/settings.dart';
import 'homeScreens/video.dart';

class home extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return homeState();
  }

}

class homeState extends State{

  int _navIndex = 0;
  PageController _pageController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 10.0,
          backgroundColor: Colors.white,
          currentIndex: _navIndex,
          showSelectedLabels: true,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 10.0,
          unselectedFontSize: 10.0,
          selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor, size: 25.0),
          unselectedIconTheme: IconThemeData(color: Colors.grey, size: 25.0),
          onTap: (change){setState((){_navIndex=change;_pageController.jumpToPage(change);});},
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(
              AssetImage("assets/images/radio.png")
              ),
              label: "RADIO",
            ),
            BottomNavigationBarItem(
                icon: ImageIcon(
                    AssetImage("assets/images/video.png")
                ),
                label: "VIDEO"),
            BottomNavigationBarItem(
                icon: ImageIcon(
                    AssetImage("assets/images/settings.png")
                ),
                label: "SETTINGS"),

          ],
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index){setState((){_navIndex=index;});},
          children: [radio(),
            video(),
            settings()],
        )
    );
  }

  @override
  void initState() {
    super.initState();
  }
}