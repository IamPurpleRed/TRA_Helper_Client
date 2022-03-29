import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '/config/constants.dart';
import '/config/palette.dart';

const double blockTitleSize = 18.0;
const double blockContentSize = 14.0;
const double blockPadding = 12.0;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double vw = MediaQuery.of(context).size.width;
    final double vh = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: vw * 0.05,
        vertical: vh * 0.02,
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
            mainAxisCellCount: (vh > Constants.smallDeviceHeight) ? 12 : 10,
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
            mainAxisCellCount: (vh > Constants.smallDeviceHeight) ? 12 : 10,
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

          // INFO: 今日行程block
          StaggeredGridTile.count(
            crossAxisCellCount: 50,
            mainAxisCellCount: 22,
            child: Container(
              child: const ScheduleToday(),
              decoration: blockDeco(),
            ),
          ),

          // INFO: 近期路線block
          StaggeredGridTile.count(
            crossAxisCellCount: 50,
            mainAxisCellCount: (vh > Constants.smallDeviceHeight) ? 38 : 28,
            child: Container(
              child: const RecentActivity(),
              decoration: blockDeco(),
            ),
          ),
        ],
      ),
    );
  }

  // INFO: block的樣式
  BoxDecoration blockDeco() {
    return BoxDecoration(
      color: Palette.primaryColor,
      borderRadius: BorderRadius.circular(10.0),
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
                color: Colors.white,
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('訂票代碼：4853731', style: TextStyle(fontSize: blockContentSize)),
                    Text('自強 301', style: TextStyle(fontSize: blockContentSize)),
                    Text('06:57 新左營 → 09:17 臺東', style: TextStyle(fontSize: blockContentSize)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 90,
                      height: 24,
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
                    Container(
                      width: 90,
                      height: 24,
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
          ),
        ],
      ),
    );
  }
}

class RecentActivity extends StatefulWidget {
  const RecentActivity({Key? key}) : super(key: key);

  static const double starIconSize = 20.0;

  @override
  State<RecentActivity> createState() => _RecentActivityState();
}

class _RecentActivityState extends State<RecentActivity> {
  @override
  Widget build(BuildContext context) {
    final double vw = MediaQuery.of(context).size.width;
    final double vh = MediaQuery.of(context).size.height;

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
                color: Colors.white,
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Text('自強 300', style: TextStyle(fontSize: blockContentSize))],
                  ),
                  minLeadingWidth: 75,
                  title: const Text('新左營 → 斗六', style: TextStyle(fontSize: blockContentSize)),
                  subtitle: const Text('08:43~10:24'),
                  trailing: InkWell(
                    child: Icon(
                      Icons.star,
                      color: Colors.yellow[600],
                      size: RecentActivity.starIconSize,
                    ),
                    onTap: () {},
                  ),
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  visualDensity: VisualDensity(vertical: (vh > Constants.smallDeviceHeight) ? -2 : -4),
                ),
                ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Text('莒光 4000', style: TextStyle(fontSize: blockContentSize))],
                  ),
                  minLeadingWidth: 75,
                  title: const Text('高雄 → 台南', style: TextStyle(fontSize: blockContentSize)),
                  subtitle: const Text('14:23~15:59'),
                  trailing: InkWell(
                    child: const Icon(
                      Icons.star,
                      color: Palette.backgroundColor,
                      size: RecentActivity.starIconSize,
                    ),
                    onTap: () {},
                  ),
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  visualDensity: VisualDensity(vertical: (vh > Constants.smallDeviceHeight) ? -2 : -4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
