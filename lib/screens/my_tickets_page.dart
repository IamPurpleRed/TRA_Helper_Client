import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '/config/user.dart';
import '/config/ticket.dart';
import '/widgets/widgets.dart';

class MyTicketsPage extends StatefulWidget {
  const MyTicketsPage({Key? key}) : super(key: key);

  @override
  State<MyTicketsPage> createState() => _MyTicketsPageState();
}

class _MyTicketsPageState extends State<MyTicketsPage> {
  bool isLoading = true; // true時顯示載入畫面，false時根據ticket變數決定
  Ticket? ticket; // 若為空顯示無車票畫面，不為空顯示車票qrcode等資訊

  @override
  Widget build(BuildContext context) {
    final double vw = MediaQuery.of(context).size.width;
    final double vh = MediaQuery.of(context).size.height;

    return Consumer<User>(
      builder: (context, user, child) {
        if (isLoading) {
          checkTicket(user);
          return loadingUI();
        } else {
          if (ticket == null) {
            return noTicketUI();
          } else {
            return hasTicketUI(vw, vh);
          }
        }
      },
    );
  }

  /* INFO: 載入畫面 */
  Widget loadingUI() {
    return const Center(
      child: Text('載入中頁面'),
    );
  }

  /* INFO: 無車票畫面 */
  Widget noTicketUI() {
    return const Center(
      child: Text('無車票頁面'),
    );
  }

  /* INFO: 有車票畫面 */
  Widget hasTicketUI(double vw, double vh) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // TODO: 把futurebuilder拿掉
          /*
            Container(
              width: vw * 0.8,
              height: vw * 0.8,
              padding: const EdgeInsets.all(20.0),
              color: Colors.white,
              child: FutureBuilder<bool>(
                future: checkTicket(user),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return Container(
                        child: QrImage(
                          data: qrcodeData,
                          version: QrVersions.auto,
                          size: vw * 0.7,
                        ),
                      );
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
            */
          Container(
            child: const Text('起點： 上車時間：', style: TextStyle(fontSize: 24)),
          ),
          Container(
            child: const Text('終點： 到站時間：', style: TextStyle(fontSize: 24)),
          ),
        ],
      ),
    );
  }

  /* INFO: 獲取車票資料函式 */
  Future<void> checkTicket(User user) async {
    Response response;

    try {
      response = await Dio().get(
        'https://tra-helper-backend.herokuapp.com/accounts/${user.id}/tickets/',
        options: Options(headers: {'Authorization': 'Token ${user.key}'}),
      );
    } on DioError {
      Widgets.dialog(context, '無法連線', 'App無法連線至伺服器，請檢查您的網路連線');
      setState(() {
        isLoading = false; // 只要有變數改變就要用setstate包起來，UI就會更新了
      });
      return;
    }

    print(response);
    print('QR_url 字串：' + response.data[0]['QR_url']);
    // 建立ticket物件
    // setState(() {
    //   ticket = Ticket();
    //   isLoading = false;
    // });
  }
}
