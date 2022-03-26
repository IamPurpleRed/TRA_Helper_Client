import 'package:flutter/material.dart';

import '/config/palette.dart';
import '/widgets/speech_to_text.dart';

class HomePageEasy extends StatefulWidget {
  HomePageEasy({Key? key}) : super(key: key);

  final speechToTextKey = GlobalKey<SpeechToTextState>();
  static const Duration animateTime = Duration(milliseconds: 200);

  @override
  State<HomePageEasy> createState() => _HomePageEasyState();
}

class _HomePageEasyState extends State<HomePageEasy> {
  bool hasResult = false; // 若沒有回覆訊息則為false，將會影響排版

  @override
  Widget build(BuildContext context) {
    final double vw = MediaQuery.of(context).size.width;
    final double vh = MediaQuery.of(context).size.height;

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
              AnimatedContainer(
                duration: HomePageEasy.animateTime,
                height: hasResult ? vh * 0.03 : vh * 0.1,
              ),
              const Text(
                '您現在位於 新左營車站',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: vh * 0.06),
              AnimatedContainer(
                duration: HomePageEasy.animateTime,
                height: hasResult ? vh * 0.3 : 0,
                child: SpeechToText(key: widget.speechToTextKey),
              ),
            ],
          ),
        ),

        // INFO: 偵測區域
        SizedBox(
          width: vw,
          height: hasResult ? vh * 0.4 : vh * 0.5,
          child: GestureDetector(
            onTap: (() => print('tap')),
            onLongPress: (() {
              widget.speechToTextKey.currentState!.resultString = '';
              widget.speechToTextKey.currentState!.startListening();
              setState(() {
                hasResult = true;
              });
            }),
            onLongPressUp: (() => widget.speechToTextKey.currentState!.stopListening()),
          ),
        ),
      ],
    );
  }
}
