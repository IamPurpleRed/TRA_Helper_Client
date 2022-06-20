import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ticket extends ChangeNotifier {
  String? url;
  String? id;
  String? user;
  String? date;
  String? start_station;
  String? end_station;
  String? train;
  String? seat;
  String? QR_url;

  Ticket();
  Ticket.iHaveData({required String this.url, required String this.id, required String this.user, required String this.date, required String this.start_station, required String this.end_station, required String this.train, required String this.seat, required String this.QR_url});

  /* INFO: 測試用函式 */
  void output() {
    print((user ?? 'url is null') + '\n' + (id ?? 'id is null') + '\n' + (user ?? 'user is null') + '\n' + (date ?? 'date is null') + '\n' + (start_station ?? 'start_station is null') + '\n' + (end_station ?? 'end_station is null') + '\n' + (train ?? 'train is null') + '\n'+ (seat ?? 'seat is null') + '\n'+ (QR_url ?? 'QR_url is null') + '\n');
  }

  /* INFO: 當資料要更新時要執行的函式 */
  Future<void> check({required String url, required String id, required String user, required String date, required String start_station, required String end_station, required String train, required String seat, required String QR_url}) async {
    this.url = url;
    this.id = id;
    this.user = user;
    this.date = date;
    this.start_station = start_station;
    this.end_station = end_station;
    this.train = train;
    this.seat = seat;
    this.QR_url = QR_url;


    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setString('url', url);
    prefs.setString('id', id);
    prefs.setString('user', user);
    prefs.setString('date', date);
    prefs.setString('start_station', start_station);
    prefs.setString('end_station', end_station);
    prefs.setString('train', train);
    prefs.setString('seat', seat);
    prefs.setString('QR_url', QR_url);


    notifyListeners();
  }

  /* INFO: 當使用者登出時要執行的函式 */
  void deleteTicket() {
    url = null;
    id = null;
    user = null;
    date = null;
    start_station=null;
    end_station=null;
    train = null;
    seat = null;
    QR_url = null;

    notifyListeners();
  }
}
