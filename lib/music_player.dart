import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:provider/provider.dart';

import 'audioPlayerProvider.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late GifController controller = GifController(vsync: this);
  late String song;
  late String audioUrl;
  late Duration _duration;
  late Duration _position;

  late AudioPlayerProvider audioPlayerProvider;

  void musicPlayerInit() {
    audioPlayerProvider.audioPlayer = AudioPlayer();
    audioPlayerProvider.audioPlayer.setSourceAsset(audioUrl);
    _duration = const Duration();
    _position = const Duration();

    audioPlayerProvider.audioPlayer.onDurationChanged
        .listen((Duration duration) {
      _duration = duration;
      setState(() {});
    });

    audioPlayerProvider.audioPlayer.onPositionChanged
        .listen((Duration position) {
      _position = position;
      setState(() {});
    });

    audioPlayerProvider.audioPlayer.onPlayerComplete.listen((event) {
      print("_audioPlayer.state : ${audioPlayerProvider.audioPlayer.state}");
      audioPlayerProvider.audioPlayer.seek(const Duration(seconds: 0));
      if (audioPlayerProvider.audioPlayer.state == PlayerState.playing) {
        audioPlayerProvider.audioPlayer.pause(); // 先暂停
        audioPlayerProvider.audioPlayer.resume(); // 再继续播放，实现循环
      }
      setState(() {
        _position = _duration;
      });
    });
  }

  void playOrPause() {
    if (audioPlayerProvider.audioPlayer.state == PlayerState.playing) {
      print('暫停播放GIF');
      audioPlayerProvider.stopSong();
      controller.stop();
    } else {
      print('開始播放GIF');
      audioPlayerProvider.playSong();
      controller.repeat();
    }
    print('Audio Player State: ${audioPlayerProvider.audioPlayer.state}');
    setState(() {});
  }

  //控制Duration的字的數量
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void initState() {
    super.initState();
    final audioProvider =
        Provider.of<AudioPlayerProvider>(context, listen: false);
    song = audioProvider.currentSong;
    audioUrl = "audio/$song.mp3";
    audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context, listen: false);
    _duration = const Duration();
    _position = const Duration();

    audioProvider.addListener(() {
      final newSong = audioProvider.currentSong;
      if (newSong != song) {
        song = newSong;
        audioUrl = "audio/$song.mp3";
        setState(() {});
      }
    });

    audioPlayerProvider.playSong();

    audioPlayerProvider.audioPlayer.onDurationChanged
        .listen((Duration duration) {
      setState(() {
        _duration = duration;
      });
    });

    audioPlayerProvider.audioPlayer.onPositionChanged
        .listen((Duration position) {
      setState(() {
        _position = position;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayerProvider.stopSong();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Gif(
                controller: controller,
                image: AssetImage("assets/images/$song.gif"),
                autostart: Autostart.loop,
                placeholder: (context) =>
                    const Center(child: CircularProgressIndicator()),
                height: 200,
                width: 200,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(song, style: const TextStyle(fontSize: 24, color: Colors.red)),
            // const SizedBox(
            //   height: 10,
            // ),
            // const Text('歌手名', style: TextStyle(color: Colors.white,fontSize: 14)),

            //音樂控制
            Slider(
              onChanged: (value) async {
                await audioPlayerProvider.audioPlayer
                    .seek(Duration(seconds: value.toInt()));
                setState(() {});
              },
              value: _position.inSeconds.toDouble(),
              min: 0,
              max: _duration.inSeconds.toDouble(),
              inactiveColor: Colors.grey,
              activeColor: Colors.red,
            ),

            Text(
              '${formatDuration(_position)} / ${formatDuration(_duration)}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    audioPlayerProvider.audioPlayer
                        .seek(Duration(seconds: _position.inSeconds - 10));
                  },
                  icon: const Icon(Icons.fast_rewind),
                  iconSize: 40,
                ),
                IconButton(
                  onPressed: playOrPause,
                  icon: Icon(audioPlayerProvider.audioPlayer.state ==
                          PlayerState.playing
                      ? Icons.pause
                      : Icons.play_arrow),
                  iconSize: 50,
                ),
                IconButton(
                  onPressed: () {
                    audioPlayerProvider.audioPlayer
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
