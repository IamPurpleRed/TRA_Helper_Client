import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/config/user.dart';

class MyTicketsPage extends StatefulWidget {
  const MyTicketsPage({Key? key}) : super(key: key);

  @override
  State<MyTicketsPage> createState() => _MyTicketsPageState();
}

class _MyTicketsPageState extends State<MyTicketsPage> {
  @override
  Widget build(BuildContext context) {
    final double vw = MediaQuery.of(context).size.width;
    final double vh = MediaQuery.of(context).size.height;

    return Consumer<User>(
      builder: (context, user, child) => Container(
        child: Text('Key=${user.key}'),
      ),
    );
    /* NOTE: 
    網頁請求是async函式，等待回復需要時間
    所以還沒傳回來之前可以先用文字"載入中"頂替，以免噴錯
    主要工作是前端&網址轉QRcode，連API很簡單照抄我的應該就好
    長寬盡量用vw(使用者螢幕寬度), vh(高度)
    帳號user，密碼password，這個帳號有一個車票資料可以抓
    */
  }
}
