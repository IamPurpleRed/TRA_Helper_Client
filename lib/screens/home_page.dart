import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '/config/constants.dart';
import '/config/palette.dart';
import '/widgets/bottom_nav_bar.dart';

const double blockTitleSize = 20.0;
const double blockContentSize = 16.0;
const double blockPadding = 16.0;
const bool loginStatus = true; // 暫時變數，有登入即為true

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;

    // INFO: block的樣式
    BoxDecoration blockDeco() {
      return BoxDecoration(
        color: Palette.primaryColor,
        borderRadius: BorderRadius.circular(10),
      );
    }

    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
        title: const Text('台鐵幫幫盲'),
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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: vw * 0.05,
          vertical: vh * 0.03,
        ),
        child: StaggeredGrid.count(
          crossAxisCount: 50,
          mainAxisSpacing: vh * 0.02,
          crossAxisSpacing: vw * 0.05,
          children: [
            // INFO: 最新消息block
            StaggeredGridTile.count(
              crossAxisCellCount: 50,
              mainAxisCellCount: 8,
              child: Container(
                child: Row(
                  children: const [
                    SizedBox(width: 8),
                    Icon(Icons.campaign),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '這是一則最新消息',
                        style: TextStyle(fontSize: blockContentSize),
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.navigate_next,
                      size: Constants.defaultIconSize,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                decoration: blockDeco(),
              ),
            ),

            // INFO: 導航block
            StaggeredGridTile.count(
              crossAxisCellCount: 25,
              mainAxisCellCount: 12,
              child: Container(
                child: Row(
                  children: const [
                    Icon(Icons.navigation),
                    Text(
                      '  導航',
                      style: TextStyle(
                        fontSize: blockTitleSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                decoration: blockDeco(),
              ),
            ),

            // INFO: 服務鈴block
            StaggeredGridTile.count(
              crossAxisCellCount: 25,
              mainAxisCellCount: 12,
              child: Container(
                child: Row(
                  children: const [
                    Icon(Icons.notifications_active),
                    Text(
                      '  服務鈴',
                      style: TextStyle(
                        fontSize: blockTitleSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                decoration: blockDeco(),
              ),
            ),

            // INFO: 列車提醒block
            StaggeredGridTile.count(
              crossAxisCellCount: 50,
              mainAxisCellCount: 20,
              child: Container(
                child: const ScheduleToday(),
                decoration: blockDeco(),
              ),
            ),

            // INFO: 近期路線block
            StaggeredGridTile.count(
              crossAxisCellCount: 50,
              mainAxisCellCount: 40,
              child: Container(
                child: const RecentActivity(),
                decoration: blockDeco(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: vw * 0.18,
        height: vh * 0.18,
        child: FloatingActionButton(
          child: const Icon(Icons.mic, size: 48),
          onPressed: () {},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class ScheduleToday extends StatefulWidget {
  const ScheduleToday({
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleToday> createState() => _ScheduleTodayState();
}

class _ScheduleTodayState extends State<ScheduleToday> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(blockPadding),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.departure_board),
              Text(
                '今日行程',
                style: TextStyle(
                  fontSize: blockTitleSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.navigate_next,
                size: Constants.defaultIconSize,
                color: Colors.white,
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('訂票代碼：4853731', style: TextStyle(fontSize: blockContentSize)),
                  Text('自強 301', style: TextStyle(fontSize: blockContentSize)),
                  Text('06:57 新左營 -> 09:17 臺東', style: TextStyle(fontSize: blockContentSize)),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 100,
                    height: 25,
                    child: const Center(
                      child: Text(
                        '尚未取票',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: blockContentSize,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 100,
                    height: 25,
                    child: const Center(
                      child: Text(
                        '12小時29分',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: blockContentSize,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class RecentActivity extends StatefulWidget {
  const RecentActivity({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentActivity> createState() => _RecentActivityState();
}

class _RecentActivityState extends State<RecentActivity> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(blockPadding),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.directions),
              Text(
                '近期路線',
                style: TextStyle(
                  fontSize: blockTitleSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.navigate_next,
                size: Constants.defaultIconSize,
                color: Colors.white,
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Text('自強 300', style: TextStyle(fontSize: blockContentSize)),
                  title: const Text('新左營 -> 斗六', style: TextStyle(fontSize: blockContentSize)),
                  trailing: InkWell(
                    child: Icon(Icons.star, color: Colors.yellow[600]),
                    onTap: () {},
                  ),
                  minLeadingWidth: 10,
                ),
                ListTile(
                  leading: const Text('莒光 4000', style: TextStyle(fontSize: blockContentSize)),
                  title: const Text('高雄 -> 台南', style: TextStyle(fontSize: blockContentSize)),
                  trailing: InkWell(
                    child: const Icon(Icons.star, color: Palette.backgroundColor),
                    onTap: () {},
                  ),
                ),
                ListTile(
                  leading: const Text('莒光 4000', style: TextStyle(fontSize: blockContentSize)),
                  title: const Text('高雄 -> 台南', style: TextStyle(fontSize: blockContentSize)),
                  trailing: InkWell(
                    child: const Icon(Icons.star, color: Palette.backgroundColor),
                    onTap: () {},
                  ),
                ),
                ListTile(
                  leading: const Text('莒光 4000', style: TextStyle(fontSize: blockContentSize)),
                  title: const Text('高雄 -> 台南', style: TextStyle(fontSize: blockContentSize)),
                  trailing: InkWell(
                    child: const Icon(Icons.star, color: Palette.backgroundColor),
                    onTap: () {},
                  ),
                ),
                ListTile(
                  leading: const Text('莒光 4000', style: TextStyle(fontSize: blockContentSize)),
                  title: const Text('高雄 -> 台南', style: TextStyle(fontSize: blockContentSize)),
                  trailing: InkWell(
                    child: const Icon(Icons.star, color: Palette.backgroundColor),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
