import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

import '/config/palette.dart';
import '/widgets/voice_interaction_field.dart';

class HomePageEasy extends StatefulWidget {
  HomePageEasy({Key? key}) : super(key: key);

  final voiceInteractionFieldKey = GlobalKey<VoiceInterationFieldState>();
  static const Duration animateTime = Duration(milliseconds: 200);

  @override
  State<HomePageEasy> createState() => _HomePageEasyState();
}

class _HomePageEasyState extends State<HomePageEasy> {
  bool hasVoiceInteractionField = false; // 初始畫面是沒有voice_interaction_field的空間的
  bool isPressing = false;

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
                width: vw * 0.65,
                height: vw * 0.65,
                child: AvatarGlow(
                    animate: isPressing,
                    endRadius: 150.0,
                    duration: const Duration(seconds: 1),
                    child: const CircleAvatar(
                      radius: 100.0,
                      backgroundColor: Palette.secondaryColor,
                      child: Icon(
                        Icons.mic,
                        size: 120,
                        color: Colors.white,
                      ),
                    )),
              ),
              AnimatedContainer(
                duration: HomePageEasy.animateTime,
                height: hasVoiceInteractionField ? 0 : vh * 0.05,
              ),
              const Text(
                '您現在位於 新左營車站',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: vh * 0.05),
              AnimatedContainer(
                duration: HomePageEasy.animateTime,
                height: hasVoiceInteractionField ? vh * 0.35 : 0,
                child: VoiceInterationField(key: widget.voiceInteractionFieldKey),
              ),
            ],
          ),
        ),

        // INFO: 偵測區域
        SizedBox(
          width: vw,
          height: hasVoiceInteractionField ? vh * 0.4 : vh * 0.5,
          child: GestureDetector(
            onTap: (() => print('tap')),
            onLongPress: (() {
              widget.voiceInteractionFieldKey.currentState!.requestString = '';
              widget.voiceInteractionFieldKey.currentState!.responseString = '';
              widget.voiceInteractionFieldKey.currentState!.startListening();
              setState(() {
                isPressing = true;
                hasVoiceInteractionField = true;
              });
            }),
            onLongPressUp: (() {
              widget.voiceInteractionFieldKey.currentState!.stopListening();
              setState(() {
                isPressing = false;
              });
            }),
          ),
        ),
      ],
    );
  }
}
