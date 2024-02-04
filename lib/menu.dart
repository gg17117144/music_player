// import 'package:flutter/material.dart';
// import 'package:assets_audio_player/assets_audio_player.dart';
//
//
// class MusicListPage extends StatefulWidget {
//   @override
//   _MusicListPageState createState() => _MusicListPageState();
// }
//
// class _MusicListPageState extends State<MusicListPage> {
//   final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
//
//   @override
//   void dispose() {
//     assetsAudioPlayer.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text('播放音樂'),
//         // child: ElevatedButton(
//         //   onPressed: () {
//         //     // 在這裡處理播放音樂的邏輯
//         //     // playMusic();
//         //   },
//         //   child: Text('播放音樂'),
//         // ),
//       ),
//     );
//   }
//
//   void playMusic() {
//     // 在這裡設定你的音樂檔案路徑，可以是 assets 中的檔案或網路上的 URL
//     final Audio audio = Audio('assets/audio/sample.mp3');
//
//     // 撥放音樂
//     assetsAudioPlayer.open(
//       audio,
//       autoStart: true,
//       showNotification: true,
//     );
//   }
// }
