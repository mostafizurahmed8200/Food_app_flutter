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

  late String _totalPriceValue = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      _saladsFuture = DBHelper.getSaladItems();
      await _loadData();
    });
  }

  // Function to load salads from the database
  Future<void> _loadSalads() async {
    List<SaladBasketSqlModel> salads = await _saladsFuture;
    setState(() {
      _salads = salads;
    });
  }

  // Function to load data from the database
  Future<void> _loadData() async {
    await _loadSalads();
    await _loadTotalPrice();
  }

// Function to load total price value from the database
  Future<void> _loadTotalPrice() async {
    int totalPrice = await DBHelper.getTotalPriceValue();
    print("Total Price --> $totalPrice");
    setState(() {
      _totalPriceValue = totalPrice.toString();
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
                        onPriceDelete: () {
                          setState(() {
                            // Remove the item from the list
                            _loadTotalPrice();
                          });
                        },
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Price",
                          style: Const.h11HeaderText,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.currency_rupee,
                              size: 20,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              _salads.isEmpty ? '0' : _totalPriceValue,
                              style: Const.headerText,
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          shape: const RoundedRectangleBorder(
                            // <-- SEE HERE
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return BottomSheetCheckOutOrder(); // Display the bottom sheet
                          },
                        );
                      },
                      child: Container(
                          height: 60,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Const.hexToColor(Const.appColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text(
                              Const.checkOutOrder,
                              style: Const.buttonText,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          )
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
  final VoidCallback onPriceDelete;

  const BasketItemWidget({
    super.key,
    required this.saladImage,
    required this.saladName,
    required this.saladPack,
    required this.saladPrice,
    required this.id,
    required this.onDelete,
    required this.onPriceDelete,
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
                  onPriceDelete();
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

class BottomSheetCheckOutOrder extends StatefulWidget {
  const BottomSheetCheckOutOrder({Key? key});

  @override
  State<BottomSheetCheckOutOrder> createState() =>
      _BottomSheetCheckOutOrderState();
}

class _BottomSheetCheckOutOrderState extends State<BottomSheetCheckOutOrder> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = MediaQuery.of(context).size.height;
    final halfScreenHeight = screenHeight / 2;

    return Container(
      color: Colors.transparent,
      height: halfScreenHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Center(child: Image.asset(Const.cancelbutton)),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24),
                  topLeft: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        Const.deliveryAddress,
                        style: Const.h1HeaderText,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Const.hexToColor(Const.editTextColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: SizedBox(
                          width: screenSize.width * .8,
                          height: 60,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Center(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: Const.deliveryAddresshintText,
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                                controller: _textEditingController,
                                onChanged: (value) {
                                  if (value.length > 10) {
                                    _textEditingController.text = '';
                                  }
                                },
                                textCapitalization:
                                    TextCapitalization.characters,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        Const.numbertocall,
                        style: Const.h1HeaderText,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Const.hexToColor(Const.editTextColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: SizedBox(
                          width: screenSize.width * .8,
                          height: 60,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Center(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: Const.numbertocallhintText,
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                                controller: _textEditingController,
                                onChanged: (value) {
                                  if (value.length > 10) {
                                    _textEditingController.text = '';
                                  }
                                },
                                textCapitalization:
                                    TextCapitalization.characters,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ), // Replace YourContentWidget with your actual content
            ),
          ),
        ],
      ),
    );
  }
}
