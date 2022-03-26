import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';

class VoiceInterationField extends StatefulWidget {
  const VoiceInterationField({Key? key}) : super(key: key);

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
    DialogFlowtter.fromFile(path: 'assets/credentials.json').then((instance) {
      dialogFlowtter = instance;
      dialogFlowtter.projectId = 'tra-helper-rwxl';
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
        responseString = '抱歉！我沒聽清楚';
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
