import 'package:flutter/material.dart';

import 'music_player.dart';

class MusicList extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function(BuildContext) onTap;

  const MusicList({super.key, required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ListTile(
        leading: Icon(
          icon,
          size: 46,
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        onTap: () {
          onTap(context);
        },
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      MusicList(
        title: 'ToothlessDancing',
        icon: Icons.question_mark,
        onTap: (context) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MusicPlayer(song: 'ToothlessDancing'),
            ),
          );
        }
      ),
      MusicList(
        title: 'BlingBangBangBorn',
        icon: Icons.question_mark,
          onTap: (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MusicPlayer(song: 'BlingBangBangBorn'),
              ),
            );
          }
      ),
      MusicList(
        title: 'Idle',
        icon: Icons.question_mark,
          onTap: (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MusicPlayer(song: 'Idle'),
              ),
            );
          }
      ),
    ]);
  }
}
