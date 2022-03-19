import 'package:flutter/material.dart';
import 'package:tra_helper/config/palette.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 0; // 由左到右

  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;

    return BottomAppBar(
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
                            color: (pageIndex == 0) ? Palette.secondaryColor : Colors.white,
                          ),
                          Text(
                            '首頁',
                            style: TextStyle(
                              color: (pageIndex == 0) ? Palette.secondaryColor : Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {},
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
                            color: (pageIndex == 1) ? Palette.secondaryColor : Colors.white,
                          ),
                          Text(
                            '班次查詢',
                            style: TextStyle(
                              color: (pageIndex == 1) ? Palette.secondaryColor : Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {},
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
                            color: (pageIndex == 2) ? Palette.secondaryColor : Colors.white,
                          ),
                          Text(
                            '我的票匝',
                            style: TextStyle(
                              color: (pageIndex == 2) ? Palette.secondaryColor : Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {},
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
                            color: (pageIndex == 3) ? Palette.secondaryColor : Colors.white,
                          ),
                          Text(
                            '探索',
                            style: TextStyle(
                              color: (pageIndex == 3) ? Palette.secondaryColor : Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
