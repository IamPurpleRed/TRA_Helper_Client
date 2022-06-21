import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
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
        }else {
          if (ticket == null) {
            print("ticket is null");
            return noTicketUI();
          } else {
            print("ticket is not null");
            return hasTicketUI(vw, vh, ticket!);
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
  Widget hasTicketUI(double vw, double vh,Ticket? ticket) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Container(
              width: vw * 0.8,
              height: vw * 0.8,
              padding: const EdgeInsets.all(20.0),
              color: Colors.white,
              child:  Container(
                        child: QrImage(
                          data: ticket!.urlQR,
                          version: QrVersions.auto,
                          size: vw * 0.7,
                        ),
              ),
          ),
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
    print('url 字串：' + response.data[0]['url']);
    String url=response.data[0]['url'];
    String id=response.data[0]['id'].toString();
    String users=response.data[0]['user'].toString();
    String date=response.data[0]['date'];
    String startStation= response.data[0]['start_station'].toString();
    String endStation= response.data[0]['end_station'].toString();
    String train=response.data[0]['train'].toString();
    String seat=response.data[0]['seat'];
    String urlQR= response.data[0]['QR_url'];
    // 建立ticket物件
    setState(() {
      if(url==null){
        return;
      }
      else{
        ticket = Ticket(
            url:url,
            id:id,
            user:users,
            date:date,
            startStation: startStation,
            endStation: endStation,
            train: train,
            seat: seat,
            urlQR: urlQR
        );
        isLoading = false;
        print('isLoading = false');
      }

    });
  }
}
