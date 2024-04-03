import 'package:e_commerce/assets/const.dart';
import 'package:flutter/material.dart';

import '../model/infomodel.dart';

class CardWidget extends StatefulWidget {
  final InfoModel infoModel; // Mark infoModel as final
  const CardWidget({super.key, required this.infoModel});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Const.fav),
          Center(
            child: Image.asset(
              widget.infoModel.saladImage,
              width: 100,
              height: 100,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(widget.infoModel.saladName),
        ],
      ),
    );
  }
}
