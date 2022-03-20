import 'package:flutter/material.dart';

import '/config/palette.dart';
import '/screens/home_page.dart';
import '/screens/schedule_search_page.dart';
import '/screens/my_tickets_page.dart';
import '/screens/explore_page.dart';

const bool loginStatus = true; // 暫時變數，有登入即為true

class MainFrame extends StatefulWidget {
  MainFrame({Key? key}) : super(key: key);

  final List<Widget> pages = [
    HomePage(),
    ScheduleSearchPage(),
    MyTicketsPage(),
    ExplorePage(),
  ];
  final List<String> pageTitles = [
    '台鐵幫幫盲',
    '班次查詢',
    '我的票匝',
    '探索',
  ];

  @override
  State<MainFrame> createState() => _MainFrameState();
}

class _MainFrameState extends State<MainFrame> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
        title: Text(widget.pageTitles[currentPageIndex]),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(12),
            child: Center(
              child: loginStatus ? Text('登入', style: TextStyle(fontSize: 20)) : Icon(Icons.account_circle),
            ),
          ),
        ],
      ),
      body: widget.pages[currentPageIndex],
      floatingActionButton: SizedBox(
        width: vw * 0.18,
        height: vh * 0.18,
        child: FloatingActionButton(
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
                    SizedBox(
                      width: vw * 0.15,
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              color: (currentPageIndex == 0) ? Palette.secondaryColor : Colors.white,
                            ),
                            Text(
                              '首頁',
                              style: TextStyle(
                                color: (currentPageIndex == 0) ? Palette.secondaryColor : Colors.white,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() => currentPageIndex = 0);
                        },
                      ),
                    ),
                    SizedBox(
                      width: vw * 0.15,
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.schedule,
                              color: (currentPageIndex == 1) ? Palette.secondaryColor : Colors.white,
                            ),
                            Text(
                              '班次查詢',
                              style: TextStyle(
                                color: (currentPageIndex == 1) ? Palette.secondaryColor : Colors.white,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() => currentPageIndex = 1);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: vw * 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: vw * 0.15,
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.confirmation_number,
                              color: (currentPageIndex == 2) ? Palette.secondaryColor : Colors.white,
                            ),
                            Text(
                              '我的票匝',
                              style: TextStyle(
                                color: (currentPageIndex == 2) ? Palette.secondaryColor : Colors.white,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() => currentPageIndex = 2);
                        },
                      ),
                    ),
                    SizedBox(
                      width: vw * 0.15,
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: (currentPageIndex == 3) ? Palette.secondaryColor : Colors.white,
                            ),
                            Text(
                              '探索',
                              style: TextStyle(
                                color: (currentPageIndex == 3) ? Palette.secondaryColor : Colors.white,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() => currentPageIndex = 3);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
