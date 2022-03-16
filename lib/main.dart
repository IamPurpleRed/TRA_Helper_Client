import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:tra_helper/config/palette.dart';

void main() {
  runApp(const TraHelperApp());
}

class TraHelperApp extends StatelessWidget {
  const TraHelperApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '台鐵幫幫盲',
      theme: ThemeData.dark(),
      home: const HomePageNormal(),
    );
  }
}

class HomePageNormal extends StatelessWidget {
  const HomePageNormal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;
    const iconSize = 32.0;

    // INFO: block的樣式
    BoxDecoration blockDeco() {
      return BoxDecoration(
        color: Palette.primaryColor,
        borderRadius: BorderRadius.circular(15),
      );
    }

    return Scaffold(
        backgroundColor: Palette.backgroundColor,
        appBar: AppBar(
          backgroundColor: Palette.primaryColor,
          title: const Text('台鐵幫幫盲'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: vw * 0.05, vertical: vh * 0.05),
          child: StaggeredGrid.count(
            crossAxisCount: 6,
            mainAxisSpacing: vh * 0.03,
            crossAxisSpacing: vw * 0.05,
            children: [
              StaggeredGridTile.count(
                crossAxisCellCount: 3,
                mainAxisCellCount: 2,
                child: Container(
                  child: Row(
                    children: const [
                      Icon(Icons.navigation, size: iconSize),
                      Text('  導航', style: TextStyle(fontSize: iconSize - 6)),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  decoration: blockDeco(),
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 3,
                mainAxisCellCount: 2,
                child: Container(
                  child: Row(
                    children: const [
                      Icon(Icons.notifications_active, size: iconSize),
                      Text('  服務鈴', style: TextStyle(fontSize: iconSize - 6)),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  decoration: blockDeco(),
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 6,
                mainAxisCellCount: 2.5,
                child: Container(
                  decoration: blockDeco(),
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 6,
                mainAxisCellCount: 4,
                child: Container(
                  decoration: blockDeco(),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.amber,
          backgroundColor: Palette.primaryColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '主畫面'),
            BottomNavigationBarItem(icon: Icon(Icons.schedule), label: "班次查詢"),
            BottomNavigationBarItem(icon: Icon(Icons.confirmation_number), label: '我的票匝'),
            BottomNavigationBarItem(icon: Icon(Icons.location_on), label: "探索"),
          ],
        ));
  }
}
