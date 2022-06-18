import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';

import '/config/constants.dart';
import '/config/palette.dart';

class VoiceInterationField extends StatefulWidget {
  const VoiceInterationField({Key? key}) : super(key: key);

  @override
  State<VoiceInterationField> createState() => VoiceInterationFieldState();
}

class VoiceInterationFieldState extends State<VoiceInterationField> {
  SpeechToText speechToText = SpeechToText();
  String requestString = '';
  late DialogFlowtter dialogFlowtter;
  List<String> responseStringList = [];

  @override
  void initState() {
    super.initState();
    initStt();
    DialogFlowtter.fromFile(path: 'assets/pr-tra-helper-credentials.json').then((instance) {
      dialogFlowtter = instance;
      dialogFlowtter.projectId = 'pr-tra-helper';
    });
  }

  void initStt() async {
    await speechToText.initialize();
    setState(() {});
  }

  void startListening() async {
    await speechToText.listen(
      onResult: (result) {
        setState(() {
          requestString = result.recognizedWords;
        });
      },
    );
  }

  void stopListening() async {
    await Future.delayed(const Duration(seconds: 1)); // 確保最後一個字有被辨認到
    await speechToText.stop();
    if (requestString == '') {
      setState(() {
        responseStringList = ['抱歉，我聽不太懂！您可以試著說「功能查詢」了解我能幫上什麼忙'];
      });
      return;
    }
    await Future.delayed(const Duration(seconds: 1)); // 確保錯字有被修正
    DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: QueryInput(text: TextInput(text: requestString, languageCode: 'zh-TW')),
    );

    try {
      List<Message> messageList = response.queryResult!.fulfillmentMessages!;
      for (int i = 0; i < messageList.length; i++) {
        responseStringList.add(messageList[i].text!.text![0]);
      }
      setState(() {});
    } catch (e) {
      setState(() {
        responseStringList = ['發生錯誤，請稍後再試'];
      });
    }
  }

  @override
  void dispose() {
    dialogFlowtter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double vw = MediaQuery.of(context).size.width;
    final double vh = MediaQuery.of(context).size.height;

    List<Widget> children = [
      /* 使用者 */
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: vw * 0.75),
            child: Container(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: (requestString == '') ? 0 : 15.0,
                  vertical: 8.0,
                ),
                child: Text(requestString, style: const TextStyle(fontSize: Constants.contentTextSize)),
              ),
              decoration: BoxDecoration(
                color: Palette.secondaryColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ],
      ),

      /* 分隔 */
      SizedBox(height: vh * 0.01),
    ];

    for (int i = 0; i < responseStringList.length; i++) {
      children.add(
        Padding(
          padding: EdgeInsets.only(bottom: vh * 0.01),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: vw * 0.75),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 8.0,
                ),
                child: Text(responseStringList[i], style: const TextStyle(fontSize: Constants.contentTextSize)),
              ),
              decoration: BoxDecoration(
                color: Palette.primaryColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
