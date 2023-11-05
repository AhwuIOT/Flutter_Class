import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'FavoriteScreen.dart';
import 'SettingScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: Text('Hello, World!'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // 处理浮动操作按钮点击事件
        },
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              arrowColor: Colors.black,
              currentAccountPictureSize: Size.square(80),
              accountName: Text('Ahwu Tsai'),
              accountEmail: Text('ahwuiot@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: Image.asset("assets/Girl_200.png"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // 处理点击"Home"的事件

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen()), // 跳转到HomeScreen
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favorites'),
              onTap: () {
                // 处理点击"Favorites"的事件
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FavoritesScreen()), // 跳转到HomeScreen
                ); // 关闭抽屉
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // 处理点击"Settings"的事件
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsScreen()), // 跳转到HomeScreen
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (int index) {
          switch (index) {
            case 0: // 当用户点击Home图标时
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen()), // 跳转到HomeScreen
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FavoritesScreen()), // 跳转到HomeScreen
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SettingsScreen()), // 跳转到HomeScreen
              );
              break; // 处理其他底部导航栏项目的情况
          }
        },
      ),
    );
  }
}
