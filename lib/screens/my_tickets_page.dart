import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import '/config/palette.dart';
import '/config/user.dart';
import '/config/ticket.dart';
import '/widgets/widgets.dart';


class MyTicketsPage extends StatefulWidget {
  const MyTicketsPage({Key? key}) : super(key: key);

  @override
  State<MyTicketsPage> createState() => _MyTicketsPageState();
}

class _MyTicketsPageState extends State<MyTicketsPage> {
  get child => null;

  @override
  Widget build(BuildContext context) {
    final double vw = MediaQuery.of(context).size.width;
    final double vh = MediaQuery.of(context).size.height;
    User user=Provider.of<User>(context);
    //Ticket ticket = Provider.of<Ticket>(context);
    String qrcodeData='https://pub.dev/packages/qr_flutter';
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: vw*0.8,
            height: vw*0.8,
            padding: EdgeInsets.all(20.0),
            color: Colors.white,

            child: FutureBuilder<bool>(
              future: checkTicket(user),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
                if(snapshot.connectionState==ConnectionState.done){

                  if(snapshot.hasError){
                    return Text("Error: ${snapshot.error}");
                  }else{
                    return Container(

                        child: QrImage(
                            data: qrcodeData,
                            version: QrVersions.auto,
                            size: vw*0.7,
                        ),
                    );
                  }
                }else{
                  return CircularProgressIndicator();
                }

              }

            ),
          ),
          Container(
            child: Text('起點： 上車時間：',style: TextStyle(fontSize: 24)),
          ),
          Container(
            child: Text('終點： 到站時間：',style: TextStyle(fontSize: 24)),
          ),
        ],
      ),
    );

    /*
    return Consumer<User>(

      builder: (context, user, child) => Container(

        child: Text('Key=${user.key}\nId=${user.id}'),

      ),
    );
    */
    /* NOTE:
    網頁請求是async函式，等待回復需要時間
    所以還沒傳回來之前可以先用文字"載入中"頂替，以免噴錯
    主要工作是前端&網址轉QRcode，連API很簡單照抄我的應該就好
    長寬盡量用vw(使用者螢幕寬度), vh(高度)
    帳號user，密碼password，這個帳號有一個車票資料可以抓
    */

  }
  /* INFO: 註冊 POST 函式 */
  Future<bool> checkTicket(User user) async {
    Response response;

    try {
      response = await Dio().get(
        'https://tra-helper-backend.herokuapp.com/accounts/${user.id}/tickets/',
        options: Options(headers: {'Authorization': 'Token ${user.key}'}),

      );
      /*
      Provider.of<Ticket>(context, listen: false).check(
          url: response.data['url'],
          id: response.data['id'],
          user: response.data['user'],
          date: response.data['date'],
          start_station: response.data['start_station'],
          end_station: response.data['end_station'],
          train: response.data['train'],
          seat: response.data['seat'],
          QR_url: response.data['QR_url'],
      ); // 更新 User 資料卻不重構 UI
      */

    } on DioError catch (e){
        Widgets.dialog(context, '無法連線', 'App無法連線至伺服器，請檢查您的網路連線');
        return false;
    }

    return true;
  }
}

