import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  final String audioUrl = "audio/toothless-dancing-meme-new-variations.mp3";
  late AudioPlayer _audioPlayer;
  late Duration _duration;
  late Duration _position;

  void playerInit() {
    _audioPlayer = AudioPlayer();
    _audioPlayer.setSourceAsset(audioUrl);
    _duration = Duration();
    _position = Duration();

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      _duration = duration;
      setState(() {});
    });

    _audioPlayer.onPositionChanged.listen((Duration position) {
      _position = position;
      setState(() {});
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _position = _duration;
      });
    });
  }

  void playOrPause() {
    if (_audioPlayer.state == PlayerState.playing)
    {
      print('暫停播放');
      _audioPlayer.pause();
    }
    else
    {
      print('開始播放');
      _audioPlayer.resume();
    }
    print('Audio Player State: ${_audioPlayer.state}');
    setState(() {

    });
  }

  @override
  void initState() {
    playerInit();
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.release();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //歌曲訊息
            Image.asset(
              'assets/icons/toothless dance.png',
              height: 200,
              width: 200,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text('Music Title標題',
                style: TextStyle(fontSize: 24, color: Colors.red)),
            const SizedBox(
              height: 10,
            ),
            const Text('歌手名', style: TextStyle(fontSize: 14)),

            //音樂控制
            Slider(
              onChanged: (value) async{
                await _audioPlayer.seek(Duration(seconds: value.toInt()));
                setState(() {

                });
              },
              value: _position.inSeconds.toDouble(),
              min: 0,
              max: _duration.inSeconds.toDouble(),
              inactiveColor: Colors.grey,
              activeColor: Colors.red,
            ),
            const Text('00:02:18 / 00:03:22'),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.fast_rewind),
                  iconSize: 40,
                ),
                IconButton(
                  onPressed: playOrPause,
                  icon: Icon(_audioPlayer.state == PlayerState.playing
                      ? Icons.pause
                      : Icons.play_arrow),
                  iconSize: 50,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.fast_forward),
                  iconSize: 40,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
