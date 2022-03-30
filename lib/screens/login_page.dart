import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/widgets.dart';
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

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()), // 點擊螢幕任一處以轉移焦點
      child: Scaffold(
        backgroundColor: Palette.backgroundColor,
        //resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: vw * 0.35,
                    height: vw * 0.35,
                    child: Image.asset('assets/logo_white.png'),
                  ),
                  const SizedBox(height: 20.0),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: vw - 40,
                    height: (selectedTitle == '註 冊' && MediaQuery.of(context).viewInsets.bottom <= 0.0) ? 400.0 : 300.0,
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Palette.primaryColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              titleSelector('登 入'),
                              titleSelector('註 冊'),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  if (selectedTitle == '註 冊')
                                    Row(
                                      children: [
                                        // NOTE: TextField 外面要包 Expanded 才能使其在同一列
                                        Expanded(child: textfield(const Icon(Icons.abc), '姓', TextInputType.text)),
                                        Expanded(child: textfield(const Icon(Icons.abc), '名', TextInputType.text)),
                                      ],
                                    ),
                                  textfield(const Icon(Icons.account_circle), '身分證字號', TextInputType.visiblePassword),
                                  textfield(const Icon(Icons.vpn_key), '密碼', TextInputType.visiblePassword),
                                  if (selectedTitle == '註 冊') textfield(const Icon(Icons.phone_android), '手機號碼', TextInputType.phone),
                                  submitButton(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // INFO: 版本號
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'version: ${packageInfo.version}',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // INFO: 標題選擇 (登入 & 註冊)
  GestureDetector titleSelector(String title) {
    return GestureDetector(
      onTap: () => setState(() {
        selectedTitle = title;
        FocusScope.of(context).requestFocus(FocusNode());
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
            margin: const EdgeInsets.only(top: 5.0),
            color: (selectedTitle == title) ? Palette.secondaryColor : Colors.transparent,
          ),
        ],
      ),
    );
  }

  // INFO: 輸入格
  Padding textfield(Icon prefixIcon, String fieldName, TextInputType keyboardType) {
    const double fontSize = 18.0;

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: TextField(
        keyboardType: keyboardType,
        obscureText: (fieldName == '密碼') ? true : false,
        style: const TextStyle(fontSize: fontSize),
        decoration: InputDecoration(
          hintText: fieldName,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: fontSize),
          contentPadding: const EdgeInsets.all(6.0),
          prefixIcon: prefixIcon,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(35.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Palette.secondaryColor),
            borderRadius: BorderRadius.circular(35.0),
          ),
        ),
      ),
    );
  }

  // INFO: 按鈕
  GestureDetector submitButton() {
    return GestureDetector(
      onTap: () {},
      child: AvatarGlow(
        animate: true,
        endRadius: 45.0,
        duration: const Duration(seconds: 3),
        repeatPauseDuration: const Duration(seconds: 3),
        child: const CircleAvatar(
          radius: 30.0,
          backgroundColor: Palette.secondaryColor,
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
