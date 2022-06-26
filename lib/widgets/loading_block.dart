import 'package:flutter/material.dart';

import '/config/palette.dart';

class LoadingBlock extends StatefulWidget {
  const LoadingBlock({Key? key}) : super(key: key);

  @override
  State<LoadingBlock> createState() => _LoadingBlockState();
}

class _LoadingBlockState extends State<LoadingBlock> with SingleTickerProviderStateMixin {
  AnimationController? ac;
  Animation<double>? a;

  @override
  void initState() {
    super.initState();
    ac = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    a = CurvedAnimation(parent: ac!, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    ac!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double vw = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        width: vw * 0.7,
        height: vw * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: vw * 0.4,
              height: vw * 0.4,
              child: FadeTransition(
                opacity: a!,
                child: Image.asset('assets/logo_white.png'),
              ),
            ),
            const Text('載入中...'),
          ],
        ),
        decoration: BoxDecoration(
          color: Palette.primaryColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}
