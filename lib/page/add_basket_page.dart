import 'package:flutter/material.dart';

import '../assets/const.dart';
import '../db/db_helper.dart';
import '../model/salad_basket_sql.dart';

class AddBasketItems extends StatefulWidget {
  const AddBasketItems({super.key});

  @override
  State<AddBasketItems> createState() => _AddBasketItemsState();
}

class _AddBasketItemsState extends State<AddBasketItems> {
  late Future<List<SaladBasketSqlModel>> _saladsFuture;
  List<SaladBasketSqlModel> _salads = [];

  @override
  void initState() {
    super.initState();
    _saladsFuture = DBHelper.getSaladItems();
    _loadSalads(); // Call function to load salads initially
  }

  // Function to load salads from the database
  void _loadSalads() async {
    List<SaladBasketSqlModel> salads = await _saladsFuture;
    setState(() {
      _salads = salads;
    });
  }

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
                  const SizedBox(width: 30),
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
            child: _salads.isEmpty
                ? const EmptyView()
                : ListView.builder(
                    itemCount: _salads.length,
                    itemBuilder: (context, index) {
                      final salad = _salads[index];
                      return BasketItemWidget(
                        saladImage: salad.saladImage!,
                        saladName: salad.saladName!,
                        saladPack: salad.saladPack!,
                        saladPrice: salad.saladPrice!,
                        id: salad.id!,
                        onDelete: () {
                          setState(() {
                            // Remove the item from the list
                            _salads.removeAt(index);
                          });
                        },
                      );
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
  final int id;
  final VoidCallback onDelete;

  const BasketItemWidget({
    super.key,
    required this.saladImage,
    required this.saladName,
    required this.saladPack,
    required this.saladPrice,
    required this.id,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      saladName,
                      style: Const.headerText,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "$saladPack Packs",
                      style: Const.bodyText,
                    ),
                  ],
                ),
              ),
              // const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.currency_rupee,
                    size: 20,
                    color: Const.hexToColor(Const.appColor),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    saladPrice,
                    style: Const.headerText,
                  ),
                ],
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () async {
                  await DBHelper.deleteSaladItem(id);
                  onDelete();
                },
                child: const Icon(
                  Icons.delete_rounded,
                  size: 30,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(height: 4),
        ],
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            Const.fruit1,
            width: 200,
            height: 200,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Empty Basket",
          style: Const.h11HeaderText,
        )
      ],
    );
  }
}
