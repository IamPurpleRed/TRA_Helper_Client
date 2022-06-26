import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends ChangeNotifier {
  int? currentPageIndex; // 使用者當前所在頁面索引
  String? id;
  String? account;
  String? key;
  String? lastname;
  String? firstname;
  String? phone;
  List<String>? bookTicketParams; // 使用者點擊語音互動結果的列車資訊按鈕

  User();
  User.iHaveData({
    required int this.currentPageIndex,
    required String this.id,
    required String this.account,
    required String this.key,
    required String this.lastname,
    required String this.firstname,
    required String this.phone,
  });

  /* INFO: 當資料要更新時要執行的函式 */
  Future<void> loginOrUpdate({
    int? currentPageIndex,
    required String id,
    required String account,
    required String key,
    required String lastname,
    required String firstname,
    required String phone,
  }) async {
    if (currentPageIndex != null) this.currentPageIndex = currentPageIndex;
    this.id = id;
    this.account = account;
    this.key = key;
    this.lastname = lastname;
    this.firstname = firstname;
    this.phone = phone;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setString('id', id);
    prefs.setString('account', account);
    prefs.setString('key', key);
    prefs.setString('lastname', lastname);
    prefs.setString('firstname', firstname);
    prefs.setString('phone', phone);

    notifyListeners();
  }

  /* INFO: 當使用者登出時要執行的函式 */
  void logout() {
    currentPageIndex = null;
    id = null;
    account = null;
    key = null;
    lastname = null;
    firstname = null;
    phone = null;

    notifyListeners();
  }
}
