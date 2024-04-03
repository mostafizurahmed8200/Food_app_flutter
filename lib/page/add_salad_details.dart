import 'package:e_commerce/assets/const.dart';
import 'package:e_commerce/db/db_helper.dart';
import 'package:flutter/material.dart';

import '../model/salad_basket_sql.dart';

class AddSaladDetails extends StatelessWidget {
  final String saladImage;
  final String saladName;
  final String saladPrice;

  AddSaladDetails(
      {super.key,
      required this.saladImage,
      required this.saladName,
      required this.saladPrice});
  String finalPrice = ''; // Define final price variable

  void handleFinalPriceChanged(String price) {
    finalPrice = price;
  }

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
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
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
                    _RowAddingCard(
                      saladPrice,
                      saladImage,
                      saladName,
                      onFinalPriceChanged: handleFinalPriceChanged,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                Const.onePack,
                                style: Const.h1HeaderText,
                              ),
                              SizedBox(
                                width: 200,
                                child: Divider(
                                  color: Const.hexToColor(Const.appColor),
                                  height: 5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            Const.onePackDetails,
                            style: Const.headerText,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            height: 5,
                          ),
                          const Text(
                            Const.onePackDetails2,
                            style: Const.bodyText,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Const.hexToColor(
                                    Const.transparentButtonColor),
                                child:
                                    const Icon(Icons.favorite_border_outlined),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  // Open the database

                                  // Create a SaladBasketSqlModel object
                                  final salad = SaladBasketSqlModel(
                                    saladImage: saladImage,
                                    saladName: saladName,
                                    saladPack:
                                        'Regular', // You may want to change this
                                    saladPrice: finalPrice,
                                  );

                                  // Insert the salad into the database
                                  await DBHelper.insertSaladTable(salad);

                                  // Navigate to the basket page
                                  Navigator.pushNamed(context, '/basketPage');
                                },
                                child: Container(
                                    height: 60,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: Const.hexToColor(Const.appColor),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                      child: Text(
                                        Const.addToBasket,
                                        style: Const.buttonText,
                                      ),
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ))
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

class _RowAddingCard extends StatefulWidget {
  final String saladPrices;

  final String saladImage;
  final String saladName;
  final Function(String) onFinalPriceChanged; // Define callback

  const _RowAddingCard(this.saladPrices, this.saladImage, this.saladName,
      {required this.onFinalPriceChanged});

  @override
  State<_RowAddingCard> createState() => _RowAddingCardState();
}

class _RowAddingCardState extends State<_RowAddingCard> {
  int value = 1;
  String getValue = '1';
  late String finalPrice;

  String getFinalPrice() {
    return finalPrice;
  }

  @override
  void initState() {
    super.initState();
    // Initialize finalValue with saladPrice
    finalPrice = widget.saladPrices;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      if (value > 1) {
                        value--;
                        getValue = value.toString();
                        updateFinalValue();
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
                      if (value < 3) {
                        value++;
                        getValue = value.toString();
                        updateFinalValue();
                      } else {
                        getValue = '3';
                      }
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
            ),
          ],
        ),
        Row(
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
              finalPrice,
              style: Const.headerText,
            ),
          ],
        ),
      ],
    );
  } // Update finalValue based on value and saladPrices

  void updateFinalValue() {
    int fGetValue = int.parse(getValue);
    int finalValueInt = fGetValue * int.parse(widget.saladPrices);
    setState(() {
      finalPrice = finalValueInt.toString();
    });
    // Pass the final price back to the callback function
    widget.onFinalPriceChanged(finalPrice);
  }
}
