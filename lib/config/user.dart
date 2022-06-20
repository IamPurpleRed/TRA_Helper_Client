import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends ChangeNotifier {
  String? id;
  String? account;
  String? key;
  String? lastname;
  String? firstname;
  String? phone;

  User();
  User.iHaveData({required String this.id, required String this.account, required String this.key, required String this.lastname, required String this.firstname, required String this.phone});

  /* INFO: 測試用函式 */
  void output() {
    print((id ?? 'id is null') + '\n' + (account ?? 'account is null') + '\n' + (key ?? 'key is null') + '\n' + (lastname ?? 'lastname is null') + '\n' + (firstname ?? 'firstname is null') + '\n' + (phone ?? 'phone is null') + '\n');
  }

  /* INFO: 當資料要更新時要執行的函式 */
  Future<void> loginOrUpdate({required String id, required String account, required String key, required String lastname, required String firstname, required String phone}) async {
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
  }

  /* INFO: 當使用者登出時要執行的函式 */
  void logout() {
    id = null;
    account = null;
    key = null;
    lastname = null;
    firstname = null;
    phone = null;
  }
}
