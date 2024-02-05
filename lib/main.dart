import 'package:flutter/material.dart';
import 'package:music_player/music_player.dart';
import 'package:music_player/wait.dart';
import 'package:music_player/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black, // 设置整个应用程序的背景颜色为黑色
        splashColor: Colors.transparent, // 设置溅墨颜色为透明
        highlightColor: Colors.transparent, // 设置高亮颜色为透明
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const CustomBody('Home'),
    const MusicPlayer(song: 'ToothlessDancing',),
    const Menu(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        //模式是底部瀏覽模式
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black, // 設定AppBar的背景颜色

        selectedLabelStyle: const TextStyle(height: 0),
        // 将选中标签文本的高度设置为0
        unselectedLabelStyle: const TextStyle(height: 0),
        // 将未选中标签文本的高度设置为0
        selectedIconTheme: const IconThemeData(size: 32, color: Colors.white),
        // 调整选中图标的样式
        unselectedIconTheme: const IconThemeData(size: 24, color: Colors.grey),
        // 调整未选中图标的样式
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: '',
          ),
        ],
      ),
    );
  }
}
