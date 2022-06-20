import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter_tts/flutter_tts.dart';

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
  FlutterTts tts = FlutterTts();

  @override
  void initState() {
    super.initState();
    initStt();
    DialogFlowtter.fromFile(path: 'assets/pr-tra-helper-credentials.json').then((instance) {
      dialogFlowtter = instance;
      dialogFlowtter.projectId = 'pr-tra-helper';
    });

    tts.setLanguage('zh-TW');
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
        tts.speak(responseStringList[0]);
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

      /* INFO: 朗讀response */
      for (int i = 0; i < responseStringList.length; i++) {
        await tts.speak(responseStringList[i]);
        await tts.awaitSpeakCompletion(true);
      }
    } catch (e) {
      setState(() {
        responseStringList = ['發生錯誤，請稍後再試'];
        tts.speak(responseStringList[0]);
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
      /* INFO: request 對話框 */
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

      /* INFO: 分隔 */
      SizedBox(height: vh * 0.01),
    ];

    /* INFO: response 對話框 */
    /* NOTE: 因為response數量不確定，因此採用動態載入 */
    for (int i = 0; i < responseStringList.length; i++) {
      /* INFO: 出現此格式代表列車資訊，將會做成按鈕形式，點擊即可導至訂票頁面 */
      if (responseStringList[i].contains('//')) {
        List<String> params = responseStringList[i].split('//');
        children.add(
          Padding(
            padding: EdgeInsets.only(bottom: vh * 0.01),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: vw * 0.75),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(color: Palette.primaryColor),
                    ),
                    TextButton(
                      child: Text('${params[0]}車次：${params[2]}上車，${params[4]}抵達'),
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 8.0,
                        ),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: Constants.contentTextSize),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }

      /* INFO: 一般對話框 */
      else {
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
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
