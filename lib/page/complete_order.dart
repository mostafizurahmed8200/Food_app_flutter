import 'package:flutter/material.dart';
import 'package:food_apps/assets/const.dart';
import 'package:food_apps/ui_widget/button_widget.dart';

class CompleteOrderPage extends StatelessWidget {
  const CompleteOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: _mColumn(context, screenSize),
      ),
    );
  }
}

Widget _mColumn(BuildContext context, Size screenSize) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(Const.completeOrderImg),
        const SizedBox(
          height: 20,
        ),
        const Text(
          Const.congratulation,
          style: Const.h11HeaderText,
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 50.0, right: 50.0),
          child: Text(
            Const.oderDone,
            textAlign: TextAlign.center,
            style: Const.headerText,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, "/trackOrder"),
          child: ButtonWidget(
            text: Const.trackOrder,
            width: screenSize.width * .4,
            height: 50,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, "/homescreen");
          },
          child: Container(
            height: 50,
            width: screenSize.width * .4,
            decoration: BoxDecoration(
              border:
                  Border.all(color: Const.hexToColor(Const.appColor), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                Const.continueShopping,
                style: TextStyle(
                  fontSize: 15,
                  color: Const.hexToColor(Const.appColor),
                  fontFamily: "jost",
                ),
              ),
            ),
          ),
        ),
      ],
    );
