import 'package:flutter/material.dart';
import 'package:music_player/music_player.dart';
import 'package:music_player/wait.dart';
import 'package:music_player/menu.dart';
import 'package:provider/provider.dart';
import 'audioPlayerProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioPlayerProvider()),
      ],
    child: const MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,// 使用Material3
        scaffoldBackgroundColor: Colors.black, // 背景黑
        splashColor: Colors.transparent, // 將點擊變透明
        highlightColor: Colors.transparent, // 將點擊變透明
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {

  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();

  static _MainPageState? of(BuildContext context) => context.findAncestorStateOfType<_MainPageState>();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();

  //start
  @override
  void initState() {
    super.initState();
  }

  void changePage(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          CustomBody('Home'),
          MusicPlayer(),
          Menu(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // currentIndex: _pageController.page?.round() ?? 0,
        onTap: (index) {
          changePage(index);
        },

        type: BottomNavigationBarType.fixed, // 模式是底部瀏覽模式
        backgroundColor: Colors.black, // 設定AppBar的背景颜色
        // 選擇的字高度設為0
        selectedLabelStyle: const TextStyle(height: 0),
        // 未選擇的字高度設為0
        unselectedLabelStyle: const TextStyle(height: 0),
        // 調整Icon樣式
        selectedIconTheme: const IconThemeData(size: 32, color: Colors.white),
        // 調整未選擇的Icon樣式
        unselectedIconTheme: const IconThemeData(size: 24, color: Colors.grey),

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
