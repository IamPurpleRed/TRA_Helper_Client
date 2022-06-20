import 'package:flutter/material.dart';
import 'package:tra_helper/config/palette.dart';

import '/widgets/components.dart';

class ScheduleSearchPage extends StatefulWidget {
  ScheduleSearchPage({Key? key}) : super(key: key);

  final trainNoController = TextEditingController();
  final fromStationController = TextEditingController();
  final toStationController = TextEditingController();

  @override
  State<ScheduleSearchPage> createState() => _ScheduleSearchPageState();
}

class _ScheduleSearchPageState extends State<ScheduleSearchPage> {
  @override
  Widget build(BuildContext context) {
    final double vw = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        width: vw * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Components.textfield(
              prefixIcon: const Icon(Icons.train),
              fieldName: '車次',
              keyboardType: TextInputType.text,
              controller: widget.trainNoController,
            ),
            Components.textfield(
              prefixIcon: const Icon(Icons.directions),
              fieldName: '起點',
              keyboardType: TextInputType.text,
              controller: widget.trainNoController,
            ),
            Components.textfield(
              prefixIcon: const Icon(Icons.sports_score),
              fieldName: '目的地',
              keyboardType: TextInputType.text,
              controller: widget.trainNoController,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(color: Palette.secondaryColor),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {},
                    child: const Text('Gradient'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
