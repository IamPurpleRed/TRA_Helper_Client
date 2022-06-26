import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/config/palette.dart';
import '/config/user.dart';
import '/screens/home_page.dart';
import '/screens/book_ticket_page.dart';
import '/screens/my_tickets_page.dart';
import '/screens/explore_page.dart';

class MainFrame extends StatefulWidget {
  MainFrame({Key? key}) : super(key: key);

  final List<Widget> _pages = [
    HomePage(),
    ScheduleSearchPage(),
    const MyTicketsPage(),
    const ExplorePage(),
  ];
  static const List<String> _pageTitles = [
    '台鐵幫幫盲',
    '訂票',
    '我的車票',
    '探索',
  ];
  static const List<IconData> _pageIcons = [
    Icons.home,
    Icons.shopping_cart,
    Icons.confirmation_number,
    Icons.location_on,
  ];

  @override
  State<MainFrame> createState() => _MainFrameState();
}

class _MainFrameState extends State<MainFrame> {
  @override
  Widget build(BuildContext context) {
    final double vw = MediaQuery.of(context).size.width;
    final double vh = MediaQuery.of(context).size.height;

    return Consumer<User>(
      builder: (context, user, child) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()), // 點擊螢幕任一處以轉移焦點
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Palette.backgroundColor,
          appBar: AppBar(
            backgroundColor: Palette.primaryColor,
            title: Text(MainFrame._pageTitles[user.currentPageIndex!]),
            centerTitle: true,
            actions: const [
              Padding(
                padding: EdgeInsets.all(12),
                child: Center(
                  child: Icon(Icons.account_circle),
                ),
              ),
            ],
          ),
          body: widget._pages[user.currentPageIndex!],
          floatingActionButton: SizedBox(
            width: vw * 0.18,
            height: vh * 0.18,
            child: FloatingActionButton(
              child: const Icon(Icons.notifications_active, size: 48),
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
                        bottomAppBarItem(user, vw, 0, '首頁'),
                        bottomAppBarItem(user, vw, 1, MainFrame._pageTitles[1]),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: vw * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        bottomAppBarItem(user, vw, 2, MainFrame._pageTitles[2]),
                        bottomAppBarItem(user, vw, 3, MainFrame._pageTitles[3]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox bottomAppBarItem(User user, double vw, int index, String text) {
    return SizedBox(
      width: vw * 0.15,
      child: InkWell(
        customBorder: const CircleBorder(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              MainFrame._pageIcons[index],
              color: (user.currentPageIndex! == index) ? Palette.secondaryColor : Colors.white,
            ),
            Text(
              text,
              style: TextStyle(
                color: (user.currentPageIndex! == index) ? Palette.secondaryColor : Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
        onTap: () {
          setState(() {
            Provider.of<User>(context, listen: false).currentPageIndex = index;
          });
        },
      ),
    );
  }
}
