import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class radio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return radioState();
  }
}

class radioState extends State {
  static const url = 'https://uk1.streamingpulse.com/ssl/7036';
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  List<AssetImage> sliderItems = [
    AssetImage("assets/images/slider_images/slider_one.jpg"),
    AssetImage("assets/images/slider_images/slider_two.jpg"),
    AssetImage("assets/images/slider_images/slider_three.jpg"),
    AssetImage("assets/images/slider_images/slider_four.jpg"),
    AssetImage("assets/images/slider_images/slider_five.jpg"),
  ];

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
            "Radio",
            style: TextStyle(color: Colors.black87),
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        // body: Container(
        //   child: Stack(
        //     children: [
        //       Align(alignment: FractionalOffset.topCenter, child: Container(
        //         height: MediaQuery.of(context).size.height / 4,
        //         child: Stack(
        //             children: [
        //               Align(alignment: FractionalOffset.center,
        //                 child: Image.asset("assets/images/radioAvatar.png"),),
        //               Align(alignment: FractionalOffset.center,
        //                 child: Card(
        //                   color: Theme.of(context).primaryColor,
        //                   shadowColor: Theme.of(context).primaryColor,
        //                   elevation: 10.0,
        //                   shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(100.0),
        //                   ),
        //                   child: Container(
        //                       height: 120.0,
        //                       width: 120.0,
        //                       decoration: BoxDecoration(
        //                         shape: BoxShape.circle,
        //                         image: DecorationImage(
        //                             image: AssetImage("assets/images/logo.png"),
        //                             fit: BoxFit.cover),
        //                       )
        //                   ),
        //                 ),
        //               ),
        //             ]
        //         ),
        //       ),),
        //       Align(alignment: FractionalOffset.center, child: Container(
        //         height: MediaQuery.of(context).size.height / 4,
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Text("Title", style: TextStyle(color: Colors.grey, fontSize: 24.0),),
        //             Padding(
        //               padding: EdgeInsets.only(top: 10.0),
        //             ),
        //             Text("Subtitle", style: TextStyle(color: Colors.grey, fontSize: 14.0),),
        //             Padding(
        //               padding: EdgeInsets.only(top: 10.0),
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               children: [Icon(Icons.mic_none_outlined, color: Colors.grey,),
        //                 Text("Artist", style: TextStyle(color: Colors.grey, fontSize: 12.0),),],
        //             )
        //           ],
        //         ),
        //       ),),
        //       Align(alignment: FractionalOffset.bottomCenter, child: Container(
        //         height: MediaQuery.of(context).size.height / 4,
        //         child: Center(
        //           child: SizedBox(
        //             height: 100.0,
        //             width: 100.0,
        //             child: ElevatedButton(
        //               style: ButtonStyle(
        //                 padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
        //                   shadowColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
        //                   backgroundColor: MaterialStateProperty.all(Colors.grey),
        //                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //                     RoundedRectangleBorder(
        //                         borderRadius: BorderRadius.circular(50.0)
        //                     ),
        //                   )
        //               ),
        //               child: isPlaying?Icon(Icons.pause_rounded, color: Theme.of(context).backgroundColor, size: 70.0,)
        //                   :Icon(Icons.play_arrow_rounded, color: Theme.of(context).backgroundColor, size: 70.0,),
        //               onPressed: (){
        //                 if(isPlaying){
        //                   setState((){isPlaying=false;});
        //                   pause();
        //                 }
        //                 else{
        //                   setState((){isPlaying=true;});
        //                   play();
        //                 }
        //               },
        //             ),
        //           ),
        //         ),
        //       ),),
        //     ],
        //   ),
        // ),
        body: Container(
          child: Stack(
            children: [
              Align(
                alignment: FractionalOffset.center,
                child: CarouselSlider(items:
                    sliderItems.map((i) =>
                    Builder(builder: (BuildContext context){
                      return Card(
                        shadowColor: Theme.of(context).primaryColor,
                          margin: EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                          elevation: 4.0,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image: DecorationImage(
                                    image: i,
                                    fit: BoxFit.cover
                                )
                            ),
                          )
                      );
                    })).toList(),
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height,
                    viewportFraction: 1.0,
                    autoPlay: true,
                    autoPlayInterval: Duration(milliseconds: 8000),
                    pauseAutoPlayOnTouch: false,
                    pauseAutoPlayInFiniteScroll: false,
                    pauseAutoPlayOnManualNavigate: false,
                    scrollPhysics: NeverScrollableScrollPhysics()
                  ),
                  
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  height: 100.0,
                  width: 100.0,
                  margin: EdgeInsets.only(bottom: 50.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(10.0),
                        padding:
                            MaterialStateProperty.all(EdgeInsets.all(10.0)),
                        shadowColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        backgroundColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.5)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                        )),
                    child: isPlaying
                        ? Icon(
                            Icons.pause_rounded,
                            color: Theme.of(context).backgroundColor,
                            size: 70.0,
                          )
                        : Icon(
                            Icons.play_arrow_rounded,
                            color: Theme.of(context).backgroundColor,
                            size: 70.0,
                          ),
                    onPressed: () {
                      if (isPlaying) {
                        setState(() {
                          isPlaying = false;
                        });
                        pause();
                      } else {
                        setState(() {
                          isPlaying = true;
                        });
                        play();
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setUrl(url);
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }

  void play() {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }
}
