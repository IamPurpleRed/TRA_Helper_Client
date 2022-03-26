import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';

import '/config/constants.dart';
import '/config/palette.dart';
import '/widgets/main_frame.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]); // 鎖定螢幕方向只能為垂直(網頁版不會鎖定)
  runApp(const TraHelperApp());
}

class TraHelperApp extends StatelessWidget {
  const TraHelperApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return MaterialApp(
      title: '台鐵幫幫盲',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        brightness: Brightness.dark,
        iconTheme: const IconThemeData(
          color: Palette.secondaryColor,
          size: Constants.defaultIconSize,
        ),
        buttonTheme: const ButtonThemeData(buttonColor: Palette.secondaryColor),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          backgroundColor: Palette.secondaryColor,
        ),
        dividerTheme: const DividerThemeData(
          color: Palette.dividerColor,
          thickness: 1,
        ),
      ),
      home: MainFrame(),
    );
  }
}
