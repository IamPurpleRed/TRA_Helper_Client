import 'package:flutter/material.dart';

import '/config/palette.dart';
import '/screens/home_page.dart';
import '/screens/home_page_easy.dart';
import '/screens/schedule_search_page.dart';
import '/screens/my_tickets_page.dart';
import '/screens/explore_page.dart';

const bool easymode = true; // 暫時變數，簡易模式即為true
const bool loginStatus = true; // 暫時變數，有登入即為true

class MainFrame extends StatefulWidget {
  MainFrame({Key? key}) : super(key: key);

  final List<Widget> _pages = [
    if (easymode) HomePageEasy(),
    if (!easymode) const HomePage(),
    const ScheduleSearchPage(),
    const MyTicketsPage(),
    const ExplorePage(),
  ];
  static const List<String> _pageTitles = [
    '台鐵幫幫盲',
    '班次查詢',
    '我的票匣',
    '探索',
  ];
  static const List<IconData> _pageIcons = [
    Icons.home,
    Icons.schedule,
    Icons.confirmation_number,
    Icons.location_on,
  ];

  @override
  State<MainFrame> createState() => _MainFrameState();
}

class _MainFrameState extends State<MainFrame> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double vw = MediaQuery.of(context).size.width;
    final double vh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
        title: Text(MainFrame._pageTitles[currentPageIndex]),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(12),
            child: Center(
              child: loginStatus ? Text('登入', style: TextStyle(fontSize: 18)) : Icon(Icons.account_circle),
            ),
          ),
        ],
      ),
      body: widget._pages[currentPageIndex],
      floatingActionButton: SizedBox(
        width: vw * 0.18,
        height: vh * 0.18,
        child: easymode
            ? FloatingActionButton(
                child: const Icon(Icons.notifications_active, size: 48),
                onPressed: () {},
              )
            : FloatingActionButton(
                child: const Icon(Icons.mic, size: 48),
                onPressed: () {},
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: vw * 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    bottomAppBarItem(vw, 0, '首頁'),
                    bottomAppBarItem(vw, 1, MainFrame._pageTitles[1]),
                  ],
                ),
              ),
              SizedBox(
                width: vw * 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    bottomAppBarItem(vw, 2, MainFrame._pageTitles[2]),
                    bottomAppBarItem(vw, 3, MainFrame._pageTitles[3]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox bottomAppBarItem(double vw, int index, String text) {
    return SizedBox(
      width: vw * 0.15,
      child: InkWell(
        customBorder: const CircleBorder(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              MainFrame._pageIcons[index],
              color: (currentPageIndex == index) ? Palette.secondaryColor : Colors.white,
            ),
            Text(
              text,
              style: TextStyle(
                color: (currentPageIndex == index) ? Palette.secondaryColor : Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
        onTap: () {
          setState(() => currentPageIndex = index);
        },
      ),
    );
  }
}
