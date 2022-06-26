import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/config/constants.dart';
import '/config/palette.dart';

class Components {
  /* INFO: 輸入格 */
  static Widget textfield({required Icon prefixIcon, required String fieldName, required TextInputType keyboardType, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: (fieldName == '密碼') ? true : false,
        style: const TextStyle(fontSize: Constants.contentTextSize),
        decoration: InputDecoration(
          hintText: fieldName,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: Constants.contentTextSize),
          contentPadding: const EdgeInsets.all(6.0),
          prefixIcon: prefixIcon,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(35.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Palette.secondaryColor),
            borderRadius: BorderRadius.circular(35.0),
          ),
        ),
      ),
    );
  }

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

  /* INFO: 載入中方塊 */
  static Widget loadingBlock(double vw) {
    return Container(
      width: vw * 0.7,
      height: vw * 0.7,
      child: Column(
        children: const [
          // FadeInImage(
          //   width: vw * 0.4,
          //   height: vw * 0.4,
          //   image: Image.asset('assets/logo_white.png'),
          // ),
          Text('載入中...'),
        ],
      ),
      decoration: BoxDecoration(
        color: Palette.primaryColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
