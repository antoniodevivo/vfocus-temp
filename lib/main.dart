import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:vfocus/controllers/articles_controller.dart';
import 'package:vfocus/models/article.dart';
import 'package:vfocus/views/home_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleAdapter());
  await Hive.openBox('articles');
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    ArticlesController articlesController = Get.put(ArticlesController());

    return GetMaterialApp(
        title: 'Vfocus',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: AppBarTheme(
              backgroundColor: Color(0xff79B4B7),
            ),
            secondaryHeaderColor: Color(0xff9D9D9D),
            backgroundColor: Color(0xffFEFBF3),
            cardColor: Color(0xffF8F0DF)),
        debugShowCheckedModeBanner: false,
        home: const AppMainPage());
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}

class AppMainPage extends StatefulWidget {
  const AppMainPage({Key? key}) : super(key: key);

  @override
  State<AppMainPage> createState() => _AppMainPageState();
}

/// This is the private State class that goes with AppMainPage.
class _AppMainPageState extends State<AppMainPage> {
  int _selectedIndex = 0;

  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    const Center(child: Text('Video')),
    const Center(child: Text('Grafici')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: const Text('Vfocus'),
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          children: _widgetOptions,
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.new_releases_outlined),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_camera_front),
            label: 'Video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.graphic_eq_sharp),
            label: 'Grafici',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[300],
        onTap: _onItemTapped,
      ),
    );
  }
}
