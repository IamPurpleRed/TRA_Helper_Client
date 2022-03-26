import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToText extends StatefulWidget {
  const SpeechToText({Key? key}) : super(key: key);

  @override
  State<SpeechToText> createState() => SpeechToTextState();
}

class SpeechToTextState extends State<SpeechToText> {
  stt.SpeechToText speechToText = stt.SpeechToText();
  bool isListening = false;
  String resultString = '';

  @override
  void initState() {
    super.initState();
    initStt();
  }

  void initStt() async {
    await speechToText.initialize();
    setState(() {});
  }

  void startListening() async {
    await speechToText.listen(
      onResult: (result) {
        setState(() {
          resultString = result.recognizedWords;
        });
      },
    );
    setState(() {});
  }

  void stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(resultString, style: TextStyle(fontSize: 20)));
  }
}
