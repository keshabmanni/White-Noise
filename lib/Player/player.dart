import 'package:flutter/material.dart';
import '../theme.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_sound/flutter_sound.dart';

class PlayerPage extends StatefulWidget {
  final String soundUrl;

  PlayerPage({@required this.soundUrl});

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  bool isPlaying = false;

  AudioPlayer audioPlayer = new AudioPlayer(mode: PlayerMode.LOW_LATENCY);
  String soundUrl;
  @override
  void initState() {
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState event) {
      print("current state $event");
    });
    audioPlayer.onPlayerCompletion.listen((event) {
      audioPlayer.stop();
      setState(() {
        isPlaying = false;
      });
    });
    soundUrl = widget.soundUrl;
    super.initState();
    //_scrollController = ScrollController( );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: (soundUrl == null)
          ? Container()
          : Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //Text(widget.soundUrl),
                  //InkWell(child: Icon(Icons.fast_rewind, color: Colors.grey, size: 40,),),
                  InkWell(
                    onTap: () {
                      getAudio();
                    },
                    child: Icon(
                      isPlaying
                          ? Icons.pause_circle_outline
                          : Icons.play_circle_outline,
                      size: 50,
                      color: isPlaying ? Colors.blueAccent : Colors.grey,
                    ),
                  ),
                  //InkWell(child: Icon(Icons.fast_forward, color: Colors.grey, size: 40,),),
                ],
              ),
            ),
    );
  }

  void getAudio() async {
    //playing
    if (isPlaying) {
      var res = await audioPlayer.pause();
      if (res == 1) {
        setState(() {
          isPlaying = false;
        });
      }
    } else {
      //play
      await audioPlayer.setUrl(
          soundUrl); // prepare the player with this audio but do not start playing
      await audioPlayer.setReleaseMode(ReleaseMode.STOP);
      var res = await audioPlayer.play(soundUrl);
      if (res == 1) {
        setState(() {
          isPlaying = true;
        });
      }
    }
  }
}
