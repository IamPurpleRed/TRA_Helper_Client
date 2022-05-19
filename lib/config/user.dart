import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  String? id;
  String? account;
  String? apiKey;
  String? lastname;
  String? firstname;
  String? phone;

  /* INFO: 測試用函式 */
  void output() {
    print((id ?? 'id is null') + '\n' + (account ?? 'account is null') + '\n' + (apiKey ?? 'apiKey is null') + '\n' + (lastname ?? 'lastname is null') + '\n' + (firstname ?? 'firstname is null') + '\n' + (phone ?? 'phone is null') + '\n');
  }

  /* INFO: 當資料有更新時要執行的函式 */
  void loginOrUpdate({String? id, String? account, String? apiKey, String? lastname, String? firstname, String? phone}) {
    this.id = id;
    this.account = account;
    this.apiKey = apiKey;
    this.lastname = lastname;
    this.firstname = firstname;
    this.phone = phone;
    notifyListeners();
  }

  /* INFO: 當使用者登出時要執行的函式 */
  void logout() {
    id = null;
    account = null;
    apiKey = null;
    lastname = null;
    firstname = null;
    phone = null;
    notifyListeners();
  }
}
