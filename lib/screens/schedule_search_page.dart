import 'package:flutter/material.dart';

class ScheduleSearchPage extends StatefulWidget {
  const ScheduleSearchPage({Key? key}) : super(key: key);

  @override
  State<ScheduleSearchPage> createState() => _ScheduleSearchPageState();
}

class _ScheduleSearchPageState extends State<ScheduleSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('班次查詢頁面'),
    );
  }
}
