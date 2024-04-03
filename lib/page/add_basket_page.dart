import 'package:e_commerce/assets/const.dart';
import 'package:flutter/material.dart';

class AddBasKetItems extends StatefulWidget {
  const AddBasKetItems({super.key});

  @override
  State<AddBasKetItems> createState() => _AddBasKetItemsState();
}

class _AddBasKetItemsState extends State<AddBasKetItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Const.hexToColor(Const.appColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Const.mContainer,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  const Text(
                    Const.myBasket,
                    style: Const.h11HeaderTextWhite,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
