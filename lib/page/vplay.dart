import 'package:camcamp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:video_player/video_player.dart';


class vPlayer extends StatefulWidget {
  final String url;
  const vPlayer({super.key, required this.url});

  @override
  State<vPlayer> createState() => _vPlayerState();
}

class _vPlayerState extends State<vPlayer> {


 late VideoPlayerController _videoPlayerController;

 @override
  void initState() {
   
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
  ]);
   _videoPlayerController = VideoPlayerController.network(widget.url)
   ..initialize().then((_){
     _videoPlayerController.play();
     setState(() {
       
     });
   });
   print(widget.url);
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _videoPlayerController.value.isInitialized ? Container(
          child: VideoPlayer(_videoPlayerController),
        ) : CircularProgressIndicator(color: Constants.maroon,)
        ),
    );
  }
}



