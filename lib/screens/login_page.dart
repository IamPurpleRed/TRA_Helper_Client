import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '/config/palette.dart';
import '/config/user.dart';
import '/widgets/components.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  final accountController = TextEditingController();
  final pwdController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  PackageInfo packageInfo = PackageInfo(appName: 'unknown', packageName: 'unknown', version: 'unknown', buildNumber: 'unknown');
  String selectedTitle = '登 入'; // 目前使用者正在登入還是註冊 tab
  bool isWorking = false; // 系統是否正在進行登入或註冊作業

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
                  child: Components.textfield(
                    prefixIcon: const Icon(Icons.abc),
                    fieldName: '姓',
                    controller: widget.lastNameController,
                    keyboardType: TextInputType.text,
                  ),
                ),
                Expanded(
                  child: Components.textfield(
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
            Components.textfield(
              prefixIcon: const Icon(Icons.phone_android),
              fieldName: '手機號碼',
              controller: widget.phoneController,
              keyboardType: TextInputType.phone,
            ),
          Components.textfield(
            prefixIcon: const Icon(Icons.account_circle),
            fieldName: '身分證字號 (請使用英文大寫)',
            controller: widget.accountController,
            keyboardType: TextInputType.visiblePassword,
          ),
          Components.textfield(
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

  /* INFO: 按鈕 */
  GestureDetector submitButton(String selectedTitle) {
    return GestureDetector(
      onTap: () async {
        setState(() => isWorking = true);

        if (selectedTitle == '註 冊') {
          await enrollTask();
        } else {
          bool status;
          status = await loginTask();
          if (status) {
            setState(() {
              Navigator.pushReplacementNamed(context, '/home');
            });
          }
        }
        setState(() => isWorking = false);
      },
      child: AvatarGlow(
        animate: true,
        endRadius: 45.0,
        duration: const Duration(seconds: 3),
        repeatPauseDuration: const Duration(seconds: 3),
        child: CircleAvatar(
          radius: 30.0,
          backgroundColor: Palette.secondaryColor,
          child: isWorking
              ? const SpinKitThreeBounce(color: Colors.white, size: 18.0)
              : const Icon(
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

    /* INFO: 登入驗證 request，若有任一環節失敗則回傳 false */
    try {
      response = await Dio().post(
        'https://tra-helper-backend.herokuapp.com/login/',
        data: {'username': widget.accountController.text, 'password': widget.pwdController.text},
      );
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400) Components.dialog(context, '登入資訊錯誤', '您填入的帳號或密碼有誤');
      } else {
        Components.dialog(context, '無法連線', 'App無法連線至伺服器，請檢查您的網路連線');
      }

      return false;
    }

    /* INFO: 資料查詢 request，前面 request 成功才會執行這裡 */
    String id = response.data['id'].toString();
    String key = response.data['key'];
    try {
      response = await Dio().get(
        'https://tra-helper-backend.herokuapp.com/accounts/$id',
        options: Options(headers: {'Authorization': 'Token $key'}),
      );
    } on DioError {
      Components.dialog(context, '無法連線', 'App無法連線至伺服器，請檢查您的網路連線');
      return false;
    }

    Provider.of<User>(context, listen: false).loginOrUpdate(
      id: id,
      account: response.data['identity_number'],
      key: key,
      lastname: response.data['last_name'],
      firstname: response.data['first_name'],
      phone: response.data['phone_number'],
    ); // 更新 User 資料卻不重構 UI

    return true;
  }

  /* INFO: 註冊 POST 函式 */
  Future<void> enrollTask() async {
    Response response;

    try {
      response = await Dio().post(
        'https://tra-helper-backend.herokuapp.com/accounts/',
        data: {
          'last_name': widget.lastNameController.text,
          'first_name': widget.firstNameController.text,
          'identity_number': widget.accountController.text,
          'password': widget.pwdController.text,
          'phone_number': widget.phoneController.text,
        },
      );
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400) Components.dialog(context, '註冊資訊錯誤', '您填入的資訊不符合規範或是有漏填');
      } else {
        Components.dialog(context, '無法連線', 'App無法連線至伺服器，請檢查您的網路連線');
      }

      return;
    }

    Components.dialog(context, '註冊成功', '請前往登入頁面登入');
    selectedTitle = '登 入';
  }
}
