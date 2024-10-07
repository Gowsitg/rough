import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String url; 

  const VideoPlayerScreen({super.key, required this.url});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    String? videoId = YoutubePlayer.convertUrlToId(widget.url);
     if (videoId == null) {
      throw Exception('Invalid YouTube URL');
    }

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true, 
        startAt: 578,   
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); 
    super.dispose();
  }

Future<bool> _onWillPop() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
       onWillPop: _onWillPop,
       child: Scaffold(
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          topActions: [
             IconButton(
                icon: Icon(Icons.arrow_back,color: Colors.white,size: 30,),
                onPressed: () {
                 _onWillPop();
                  Navigator.pop(context);

                },
              ),
          ],
        ),
      ),
       )
    );
  }
}

// void main() {
//   runApp(
//     MaterialApp(
//       home: VideoPlayerScreen(utl), // Pass the URL here
//     ),
//   );
// }
