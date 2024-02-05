import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:gif/gif.dart';

class MusicPlayer extends StatefulWidget {
  final String song;

  const MusicPlayer({Key? key, required this.song});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> with TickerProviderStateMixin{
  late GifController controller= GifController (vsync: this);
  late String song;
  late String audioUrl;
  // final String audioUrl = "audio/toothlessDance.mp3";
  late AudioPlayer _audioPlayer;
  late Duration _duration;
  late Duration _position;

  void musicPlayerInit() {
    _audioPlayer = AudioPlayer();
    _audioPlayer.setSourceAsset(audioUrl);
    _duration = const Duration();
    _position = const Duration();

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      _duration = duration;
      setState(() {});
    });

    _audioPlayer.onPositionChanged.listen((Duration position) {
      _position = position;
      setState(() {});
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      print("_audioPlayer.state : ${_audioPlayer.state}");
      _audioPlayer.seek(const Duration(seconds: 0));
      if (_audioPlayer.state == PlayerState.playing) {
        _audioPlayer.pause(); // 先暂停
        _audioPlayer.resume(); // 再继续播放，实现循环
      }
      setState(() {
        _position = _duration;
      });
    });
  }

  void playOrPause() {
    if (_audioPlayer.state == PlayerState.playing) {
      print('暫停播放');
      _audioPlayer.pause();
      controller.stop();
    } else {
      print('開始播放');
      _audioPlayer.resume();
      controller.reset();
      controller.forward();
    }
    print('Audio Player State: ${_audioPlayer.state}');
    setState(() {});
  }

  //控制Duration的字的數量
  String formatDuration(Duration duration){
    String twoDigits(int n) => n.toString().padLeft(2,"0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  //start
  @override
  void initState() {
    song = widget.song;
    audioUrl = "audio/$song.mp3";
    print("audioUrl:$audioUrl");
    musicPlayerInit();
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
            Gif(
              controller: controller,
              image: AssetImage("assets/images/$song.gif"),
              autostart: Autostart.loop,
              placeholder: (context) =>
                const Center(child: CircularProgressIndicator()),
              height: 200,
              width: 200,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(song,
                style: const TextStyle(fontSize: 24, color: Colors.red)),
            const SizedBox(
              height: 10,
            ),
            // const Text('歌手名', style: TextStyle(color: Colors.white,fontSize: 14)),

            //音樂控制
            Slider(
              onChanged: (value) async {
                await _audioPlayer.seek(Duration(seconds: value.toInt()));
                setState(() {});
              },
              value: _position.inSeconds.toDouble(),
              min: 0,
              max: _duration.inSeconds.toDouble(),
              inactiveColor: Colors.grey,
              activeColor: Colors.red,
            ),

            Text('${formatDuration(_position)} / ${formatDuration(_duration)}',style: TextStyle(color: Colors.white,),),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _audioPlayer
                        .seek(Duration(seconds: _position.inSeconds - 10));
                  },
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
                  onPressed: () {
                    _audioPlayer
                        .seek(Duration(seconds: _position.inSeconds + 10));
                  },
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
