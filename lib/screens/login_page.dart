import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:dio/dio.dart';

import '/config/palette.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  final usernameController = TextEditingController();
  final pwdController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /* INFO: Logo */
                  SizedBox(
                    width: vw * 0.35,
                    height: vw * 0.35,
                    child: Image.asset('assets/logo_white.png'),
                  ),
                  const SizedBox(height: 20.0),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
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
                          Expanded(child: formBody()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /* INFO: 版本號 */
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

  /* INFO: 標題選擇 (登入 & 註冊) */
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

  /* INFO: 表單內容 */
  SingleChildScrollView formBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          if (selectedTitle == '註 冊')
            /* INFO: 姓名欄位 (註冊專用) */
            Row(
              children: [
                // NOTE: TextField 外面要包 Expanded 才能使其在同一列
                Expanded(
                  child: textfield(
                    prefixIcon: const Icon(Icons.abc),
                    fieldName: '姓',
                    controller: widget.lastNameController,
                    keyboardType: TextInputType.text,
                  ),
                ),
                Expanded(
                  child: textfield(
                    prefixIcon: const Icon(Icons.abc),
                    fieldName: '名',
                    controller: widget.firstNameController,
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),

          /* INFO: 手機欄位 (註冊專用) */
          if (selectedTitle == '註 冊')
            textfield(
              prefixIcon: const Icon(Icons.phone_android),
              fieldName: '手機號碼',
              controller: widget.phoneController,
              keyboardType: TextInputType.phone,
            ),
          textfield(
            prefixIcon: const Icon(Icons.account_circle),
            fieldName: '身分證字號 (請使用英文大寫)',
            controller: widget.usernameController,
            keyboardType: TextInputType.visiblePassword,
          ),
          textfield(
            prefixIcon: const Icon(Icons.vpn_key),
            fieldName: '密碼',
            controller: widget.pwdController,
            keyboardType: TextInputType.visiblePassword,
          ),
          submitButton(selectedTitle),
        ],
      ),
    );
  }

  /* INFO: 輸入格 */
  Padding textfield({required Icon prefixIcon, required String fieldName, required TextInputType keyboardType, required TextEditingController controller}) {
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

  /* INFO: 按鈕 */
  GestureDetector submitButton(String selectedTitle) {
    return GestureDetector(
      onTap: () async {
        // TODO: 按鈕顯示載入動畫

        if (selectedTitle == '註 冊') {
          bool status = await enrollTask();
        } else {
          await loginTask();
        }

        setState(() {});
      },
      child: const AvatarGlow(
        animate: true,
        endRadius: 45.0,
        duration: Duration(seconds: 3),
        repeatPauseDuration: Duration(seconds: 3),
        child: CircleAvatar(
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

  /* INFO: 登入 POST 函式 */
  Future<bool> loginTask() async {
    Response response;

    try {
      response = await Dio().post(
        'https://tra-helper-backend.herokuapp.com/rest-auth/login/',
        data: {'username': widget.usernameController, 'password': widget.pwdController},
      );
    } catch (e) {
      errorDialog(context, '無法連線', 'App無法連線至伺服器，請檢查您的網路連線');
      return false;
    }

    if (response.statusCode == 200) {
      // TODO: 寫入資料到App
      return true;
    } else {
      errorDialog(context, '發生錯誤', '您填入的資訊有誤'); // TODO: 擷取錯誤訊息並輸出
      return false;
    }
  }

  /* INFO: 註冊 POST 函式 */
  Future<bool> enrollTask() async {
    // Response response;

    // try {
    //   response = await Dio().post(
    //     'https://tra-helper-backend.herokuapp.com/registration/tra-users/',
    //     data: {
    //       'username': widget.usernameController,
    //       'password1': widget.pwdController,
    //       'password2': widget.pwdController, // 不做確認密碼欄位
    //       'email': '${widget.usernameController}@trahelper.com.tw', // 不做電子郵件欄位
    //       'last_name': widget.lastNameController,
    //       'first_name': widget.firstNameController,
    //       'phone_number': widget.phoneController,
    //       'is_visually_impaired': isVisuallyImpaired
    //     },
    //   );
    // } catch (e) {
    //   returnThisIfFail['log'] = e.toString();
    //   return returnThisIfFail;
    // }
    return false;
  }

  /* INFO: 發生錯誤的提示方塊 */
  void errorDialog(BuildContext context, String title, String content) {
    AlertDialog dialog = AlertDialog(
      title: Text(title),
      content: Text(content),
      scrollable: true,
      actions: [
        TextButton(
          child: const Text('確認'),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}