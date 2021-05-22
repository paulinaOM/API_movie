import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeScreen extends StatefulWidget {
  YoutubeScreen({
    Key key,
    @required this.videoId,
  }) : super(key: key);

  final String videoId;

  @override
  _YoutubeScreenState createState() => _YoutubeScreenState(videoId);
}

class _YoutubeScreenState extends State<YoutubeScreen> {
  YoutubePlayerController _controller;
  double _volume = 30.0;
  bool _isPlayerReady = false;
  String idVideoInitial;
  
  _YoutubeScreenState(idVideo){
    this.idVideoInitial = idVideo;
  }

  
  @override
  void initState() { 
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: idVideoInitial,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
        hideThumbnail: false
      )
    )..addListener(listener);
  }

  void listener(){
    if (_isPlayerReady && mounted) {
      setState(() {
        _controller.setVolume(_volume.round());
        _controller.unMute();
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red[600],
          onReady: () {
            _isPlayerReady = true;
          },
      ),
      builder: (context, player) => Container(
        height: 400,
        child: player,
      ),
    );
  }
}