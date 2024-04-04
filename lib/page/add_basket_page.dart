import 'package:e_commerce/assets/const.dart';
import 'package:flutter/material.dart';

import '../db/db_helper.dart';
import '../model/salad_basket_sql.dart';

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
            flex: 6,
            child: FutureBuilder<List<SaladBasketSqlModel>>(
              future: DBHelper.getSaladItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final salads = snapshot.data!;

                  return ListView.builder(
                    itemCount: salads.length,
                    itemBuilder: (context, index) {
                      final salad = salads[index];

                      return BasketItemWidget(
                        saladImage: salad.saladImage!,
                        saladName: salad.saladName!,
                        saladPack: salad.saladPack!,
                        saladPrice: salad.saladPrice!,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BasketItemWidget extends StatelessWidget {
  final String saladImage;
  final String saladName;
  final String saladPack;
  final String saladPrice;

  const BasketItemWidget(
      {super.key,
      required this.saladImage,
      required this.saladName,
      required this.saladPack,
      required this.saladPrice});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Const.hexToColor(Const.transparentButton2Color),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipOval(
                      child: Image.asset(
                        saladImage,
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(saladName),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(saladPack)
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
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
                      width: 5,
                    ),
                    Text(
                      saladPrice,
                      style: Const.headerText,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {},
                  child: const SizedBox(
                    child: Icon(
                      Icons.delete_rounded,
                      size: 30,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 4,
          ),
        ],
      ),
    );
  }
}
