import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Widgets {
  /* INFO: 提示方塊 */
  static void dialog(BuildContext context, String title, String content) {
    var dialog = (Platform.isAndroid)
        ? AlertDialog(
            title: Text(title),
            content: Text(content),
            scrollable: true,
            actions: [
              TextButton(
                child: const Text('確認'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          )
        : CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
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
