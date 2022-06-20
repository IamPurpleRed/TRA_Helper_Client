import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

import '/config/palette.dart';
import '/widgets/voice_interaction_field.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  final voiceInteractionFieldKey = GlobalKey<VoiceInterationFieldState>();
  static const Duration animateTime = Duration(milliseconds: 200);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool hasVoiceInteractionField = false; // 初始畫面是沒有voice_interaction_field 的空間的
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
                width: vh * 0.25,
                height: vh * 0.25,
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
                  ),
                ),
              ),
              AnimatedContainer(
                duration: HomePage.animateTime,
                height: hasVoiceInteractionField ? vh * 0.01 : vh * 0.05,
              ),
              const Text(
                '您現在位於 新左營站',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: vh * 0.05),
              AnimatedContainer(
                duration: HomePage.animateTime,
                width: vw * 0.9,
                height: hasVoiceInteractionField ? vh * 0.32 : 0,
                child: SingleChildScrollView(child: VoiceInterationField(key: widget.voiceInteractionFieldKey)),
              ),
              SizedBox(height: vh * 0.03),
            ],
          ),
        ),

        /* INFO: 偵測區域 */
        SizedBox(
          width: vw,
          height: hasVoiceInteractionField ? vh * 0.4 : vh * 0.5,
          child: GestureDetector(
            onTap: (() {
              widget.voiceInteractionFieldKey.currentState!.tts.stop();
            }),
            onLongPress: (() {
              VoiceInterationFieldState state = widget.voiceInteractionFieldKey.currentState!;
              state.tts.stop();
              state.requestString = '';
              state.responseStringList = [];
              state.startListening();
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
