import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'audioPlayerProvider.dart';
import 'main.dart';

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
          style: const TextStyle(color: Colors.white, fontSize: 24),
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
    final audioProvider = Provider.of<AudioPlayerProvider>(context, listen: false);
    return ListView(children: <Widget>[
      MusicList(
        title: 'ToothlessDancing',
        icon: Icons.question_mark,
        onTap: (context) {
          audioProvider.setSong('ToothlessDancing');
          MainPage.of(context)?.changePage(1);
        }
      ),
      MusicList(
        title: 'BlingBangBangBorn',
        icon: Icons.question_mark,
          onTap: (context) {
            audioProvider.setSong('BlingBangBangBorn');
            MainPage.of(context)?.changePage(1);
          }
      ),
      MusicList(
        title: 'Idle',
        icon: Icons.question_mark,
          onTap: (context) {
            audioProvider.setSong('Idle');
            MainPage.of(context)?.changePage(1);
          }
      ),
    ]);
  }
}
