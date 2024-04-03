import 'package:e_commerce/assets/const.dart';
import 'package:flutter/material.dart';

class AddSaladDetails extends StatelessWidget {
  final String saladImage;
  final String saladName;
  final String saladPrice;

  const AddSaladDetails(
      {super.key,
      required this.saladImage,
      required this.saladName,
      required this.saladPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Const.hexToColor(Const.appColor),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Container(
                  color: Const.hexToColor(Const.appColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Const.mContainer),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: ClipOval(
                              child: Image.asset(
                                fit: BoxFit.cover,
                                saladImage,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      saladName,
                      style: Const.h11HeaderText,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const _RowAddingCard(),
                        _RowMoneyAdd(saladPrice: saladPrice),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      height: 5,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RowMoneyAdd extends StatelessWidget {
  final String saladPrice;

  const _RowMoneyAdd({required this.saladPrice});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 35,
          height: 35,
          child: Icon(
            Icons.currency_rupee,
            size: 20,
            color: Const.hexToColor(Const.appColor),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          saladPrice,
          style: Const.headerText,
        ),
      ],
    );
  }
}

class _RowAddingCard extends StatefulWidget {
  const _RowAddingCard();

  @override
  State<_RowAddingCard> createState() => _RowAddingCardState();
}

class _RowAddingCardState extends State<_RowAddingCard> {
  int value = 1;
  String getValue = '1';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            setState(() {
              if (value > 1) {
                value--;

                getValue = value.toString();
              } else {
                getValue = '1';
              }
            });
          },
          child: SizedBox(
            width: 35,
            height: 35,
            child: CircleAvatar(
              backgroundColor: Const.hexToColor(Const.editTextColor),
              child: const Icon(
                Icons.remove,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          getValue,
          style: Const.headerText,
        ),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            setState(() {
              value++;
              getValue = value.toString();
            });
          },
          child: SizedBox(
            width: 35,
            height: 35,
            child: CircleAvatar(
              backgroundColor: Const.hexToColor(Const.addbtnColor),
              child: Icon(
                Icons.add,
                color: Const.hexToColor(Const.appColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
