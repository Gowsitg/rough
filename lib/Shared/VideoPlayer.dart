import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vanthar/Shared/CustomVideoControls.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';

class UniversalVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const UniversalVideoPlayer({super.key, required this.videoUrl});

  @override
  _UniversalVideoPlayerState createState() => _UniversalVideoPlayerState();
}

class _UniversalVideoPlayerState extends State<UniversalVideoPlayer> {
  late YoutubePlayerController _youtubeController;
  late FlickManager _flickManager;
  bool _isYouTube = false;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();

    String? videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);

    if (videoId != null) {
      _isYouTube = true;
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );

      _youtubeController.addListener(() {
        if (mounted) {
          setState(() {
            _isFullScreen = _youtubeController.value.isFullScreen;
          });
        }
      });
    } else {
      _flickManager = FlickManager(
        videoPlayerController:
            VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl)),
      );
    }
  }

  Future<bool> _onWillPop() async {
    if (_isFullScreen) {
      if (_isYouTube) {
        _youtubeController.toggleFullScreenMode();
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
      }
      setState(() {
        _isFullScreen = false;
      });
      return Future.value(false); 
    }

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    if (_isYouTube) {
      if (_youtubeController.value.isPlaying) {
        _youtubeController.pause();
      }
      _youtubeController.dispose();
    } else {
      _flickManager.dispose();
    }

    return Future.value(true);
  }

  @override
  void dispose() {
    if (_isYouTube) {
      _youtubeController.dispose();
    } else {
      _flickManager.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        
        body: Center(
          child: _isYouTube
              ? AspectRatio(
                  aspectRatio: 16 / 9,
                  child: YoutubePlayer(
                    controller: _youtubeController,
                    showVideoProgressIndicator: true,
                    onReady: () {
                      // Detect fullscreen mode
                      _youtubeController.toggleFullScreenMode();
                    },
                  ),
                )
              : AspectRatio(
                  aspectRatio: 16 / 8,
                  child: FlickVideoPlayer(
                    flickManager: _flickManager,
                    flickVideoWithControls: FlickVideoWithControls(
                      controls: FlickCustomControls(
                        
                      )
                    ),
                    preferredDeviceOrientation: [
                      DeviceOrientation.landscapeRight,
                      DeviceOrientation.landscapeLeft,
                    ],
                    systemUIOverlay: [],
                  ),
                ),
        ),
      ),
    );
  }
}
