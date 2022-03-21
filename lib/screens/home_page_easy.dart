import 'package:flutter/material.dart';
import 'package:tra_helper/config/palette.dart';

class HomePageEasy extends StatelessWidget {
  const HomePageEasy({Key? key}) : super(key: key);

  static const bool hasResult = false; // 暫時變數，若沒有回覆訊息則為false

  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: vw * 0.6,
                height: vw * 0.6,
                child: const Material(
                  color: Palette.secondaryColor,
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.mic,
                    size: 120,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: hasResult ? vh * 0.03 : vh * 0.1),
              Text('您現在位於 新左營車站', style: TextStyle(fontSize: 24)),
              SizedBox(height: vh * 0.03),
              // INFO: Result預留空間
              // SizedBox(
              //   height: vh * 0.3,
              //   child: Container(),
              // ),
            ],
          ),
        ),
        SizedBox(
          width: vw,
          height: hasResult ? vh * 0.4 : vh * 0.5,
          child: GestureDetector(
            onTap: (() {
              print('tap');
            }),
            onLongPress: (() {
              print('long press');
            }),
            onLongPressUp: (() {
              print('long press up');
            }),
          ),
        ),
      ],
    );
  }
}
