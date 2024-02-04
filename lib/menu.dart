import 'package:flutter/material.dart';

class MusicList extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onTap;

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
        onTap: onTap,
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
        title: 'toothless-dancing',
        icon: Icons.question_mark,
        onTap: () {
          print('撥放toothless-dancing');
        },
      ),
      MusicList(
        title: 'bang-bang-born',
        icon: Icons.question_mark,
        onTap: () {
          print('撥放bang-bang-born');
        },
      ),
      MusicList(
        title: 'idle',
        icon: Icons.question_mark,
        onTap: () {
          print('撥放idle');
        },
      ),
    ]);
  }
}
