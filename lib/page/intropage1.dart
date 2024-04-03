import 'package:e_commerce/assets/const.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Const.hexToColor('#FFA451'),
                image: const DecorationImage(
                  image: AssetImage(Const.fruit1),
                ),
                /*  borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ), */
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: getIntro(screenSize),
          )
        ],
      ),
    );
  }

  SizedBox getIntro(Size screenSize) {
    return SizedBox(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 30,
        ),

        //Salad Combo Header
        const Text(
          Const.saladCombo,
          style: Const.headerText,
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            Const.deliverInfo,
            textAlign: TextAlign.center,
            style: Const.sub_headerText,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/intro2'),
          child: Container(
              height: 50,
              width: screenSize.width * .8,
              decoration: BoxDecoration(
                  color: Const.hexToColor('#FFA451'),
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text(
                  Const.letsContinue,
                  style: Const.buttonText,
                ),
              )),
        )
      ],
    ));
  }
}
