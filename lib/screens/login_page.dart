import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '/config/palette.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  PackageInfo packageInfo = PackageInfo(appName: 'unknown', packageName: 'unknown', version: 'unknown', buildNumber: 'unknown');
  String selectedTitle = '登 入';

  @override
  void initState() {
    super.initState();
    initPackageInfo();
  }

  void initPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double vw = MediaQuery.of(context).size.width;
    final double vh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 20.0,
            child: Text(
              'version: ${packageInfo.version}',
              textAlign: TextAlign.center,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: vw * 0.35,
                height: vw * 0.35,
                child: Image.asset('assets/logo_white.png'),
              ),
              const SizedBox(height: 20.0),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: vw - 40,
                height: (selectedTitle == '註 冊') ? 400.0 : 300.0,
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Palette.primaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          titleSelector('登 入'),
                          titleSelector('註 冊'),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      (selectedTitle == '註 冊')
                          ? Row(
                              children: [
                                // Note: TextField 外面要包 Expanded 才能使其在同一列
                                Expanded(child: textfield(Icon(Icons.abc), '姓')),
                                Expanded(child: textfield(Icon(Icons.abc), '名')),
                              ],
                            )
                          : const SizedBox(height: 0),
                      textfield(Icon(Icons.account_circle), '身分證字號'),
                      textfield(Icon(Icons.vpn_key), '密碼'),
                      (selectedTitle == '註 冊') ? textfield(Icon(Icons.phone_android), '手機號碼') : const SizedBox(height: 0),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // INFO: 標題選擇 (登入 & 註冊)
  GestureDetector titleSelector(String title) {
    return GestureDetector(
      onTap: () => setState(() {
        selectedTitle = title;
      }),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: (selectedTitle == title) ? Colors.white : Colors.grey,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: 55.0,
            height: 3.0,
            margin: EdgeInsets.only(top: 5.0),
            color: (selectedTitle == title) ? Palette.secondaryColor : Colors.transparent,
          ),
        ],
      ),
    );
  }

  // INFO: 輸入格
  Padding textfield(Icon prefixIcon, String fieldName) {
    const double fontSize = 18.0;
    Color enabledColor = Colors.grey[300]!;

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: TextField(
        style: TextStyle(fontSize: fontSize),
        decoration: InputDecoration(
          hintText: fieldName,
          hintStyle: TextStyle(color: enabledColor, fontSize: fontSize),
          contentPadding: EdgeInsets.all(10.0),
          prefixIcon: prefixIcon,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: enabledColor),
            borderRadius: BorderRadius.circular(35.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.secondaryColor),
            borderRadius: BorderRadius.circular(35.0),
          ),
        ),
      ),
    );
  }
}
