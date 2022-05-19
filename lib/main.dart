import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

import '/config/constants.dart';
import '/config/palette.dart';
import '/config/user.dart';
import '/screens/login_page.dart';
import '/screens/main_frame.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]); // 鎖定螢幕方向只能為垂直(網頁版不會鎖定)
  runApp(
    ChangeNotifierProvider(
      create: (context) => User(), // 使用者資料
      child: const TraHelperApp(),
    ),
  );
}

class TraHelperApp extends StatelessWidget {
  const TraHelperApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return Consumer<User>(
      builder: (context, user, child) => MaterialApp(
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
          checkboxTheme: CheckboxThemeData(fillColor: MaterialStateProperty.all(Palette.secondaryColor)),
        ),
        initialRoute: (user.apiKey == null) ? '/login' : '/home', // NOTE: 若 User 資料為空，則前往登入頁面
        routes: {
          '/home': (context) => MainFrame(),
          '/login': (context) => LoginPage(),
        },
      ),
    );
  }
}
