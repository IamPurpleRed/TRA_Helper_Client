import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter_tts/flutter_tts.dart';

class VoiceInterationField extends StatefulWidget {
  VoiceInterationField({Key? key}) : super(key: key);

  final FlutterTts tts = FlutterTts();

  @override
  State<VoiceInterationField> createState() => VoiceInterationFieldState();
}

class VoiceInterationFieldState extends State<VoiceInterationField> {
  SpeechToText speechToText = SpeechToText();
  String requestString = '';

  late DialogFlowtter dialogFlowtter;
  String responseString = '';

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
        responseString = '抱歉，我聽不太懂！您可以試著說「功能查詢」了解我能幫上什麼忙';
      });
      return;
    }
    DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: QueryInput(text: TextInput(text: requestString, languageCode: 'zh-TW')),
    );

    if (response.message == null) return;
    setState(() {
      responseString = response.text!;
    });
  }

  @override
  void dispose() {
    dialogFlowtter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(requestString, style: const TextStyle(fontSize: 20)),
        Text(responseString, style: const TextStyle(fontSize: 20)),
      ],
    );
  }
}
