import 'package:flutter/material.dart';

class Ticket extends ChangeNotifier {
  String url;
  String id;
  String user;
  String date;
  String startStation;
  String endStation;
  String train;
  String seat;
  String urlQR;

  Ticket({
    required this.url,
    required this.id,
    required this.user,
    required this.date,
    required this.startStation,
    required this.endStation,
    required this.train,
    required this.seat,
    required this.urlQR,
  });
}
