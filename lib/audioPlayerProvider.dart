import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerProvider extends ChangeNotifier {
  late AudioPlayer audioPlayer;
  late String _currentSong;

  AudioPlayerProvider() {
    audioPlayer = AudioPlayer();
    audioPlayer.setReleaseMode(ReleaseMode.release);
    // _currentSong = 'BlingBangBangBorn';
    _currentSong = '';
  }

  String get currentSong => _currentSong;



  void playCurrentSong() {
    audioPlayer.resume();
    notifyListeners();
  }

  void setSong(String song){
    _currentSong = song;
    Source source = AssetSource("audio/$song.mp3");
    // audioPlayer.setSourceAsset("audio/$song.mp3");
    audioPlayer.play(source);
    notifyListeners();
  }

  void playSong() {
    audioPlayer.resume();
    notifyListeners();
  }

  void stopSong() {
    print("暫停音樂");
    audioPlayer.pause();
    notifyListeners();
  }

}
