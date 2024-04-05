import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../assets/const.dart';
import '../db/db_helper.dart';
import '../model/salad_basket_sql.dart';
import '../ui_widget/button_widget.dart';

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Const.mContainer,
                    ),
                  ),
                  const Text(
                    Const.myBasket,
                    style: Const.h11HeaderTextWhite,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/homescreen'),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.home_sharp,
                          size: 40,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
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
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: Colors.transparent,
                          shape: const RoundedRectangleBorder(
                            // <-- SEE HERE
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return const BottomSheetCheckOutOrder(); // Display the bottom sheet
                          },
                        );
                      },
                      child: const ButtonWidget(
                        height: 60,
                        width: 200,
                        text: Const.checkOutOrder,
                      ),
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
  const BottomSheetCheckOutOrder({super.key});

  @override
  State<BottomSheetCheckOutOrder> createState() =>
      _BottomSheetCheckOutOrderState();
}

class _BottomSheetCheckOutOrderState extends State<BottomSheetCheckOutOrder> {
  final TextEditingController _textEditingControllerDelivery =
      TextEditingController();
  final TextEditingController _textEditingControllerPhoneNumber =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = MediaQuery.of(context).size.height;
    final halfScreenHeight = screenHeight / 2;
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: mediaQueryData.viewInsets,
      child: Container(
        color: Colors.transparent,
        height: halfScreenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
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
                          _mDeliveryAddressEdiText(
                              screenSize, _textEditingControllerDelivery),
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
                          _mDeliveryPhoneNumberEdiText(
                              screenSize, _textEditingControllerPhoneNumber),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //Pay on delivery
                              GestureDetector(
                                onTap: () {
                                  // Add your onTap logic here
                                },
                                child: Container(
                                  height: 50,
                                  width: screenSize.width *
                                      0.3, // Adjust width as needed
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Const.hexToColor(Const.appColor),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      Const.payondelivery,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Const.hexToColor(Const.appColor),
                                        fontFamily: "jost",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenSize.width * 0.2,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    shape: const RoundedRectangleBorder(
                                      // <-- SEE HERE
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25.0),
                                      ),
                                    ),
                                    builder: (BuildContext context) {
                                      return const CreditCardBottomSheetCheckOutOrder(); // Display the bottom sheet
                                    },
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  width: screenSize.width *
                                      0.3, // Adjust width as needed
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Const.hexToColor(Const.appColor),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      Const.paywithCard,
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
                          )
                        ],
                      ),
                    ],
                  ),
                ), // Replace YourContentWidget with your actual content
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Credit Card Bottomnav
class CreditCardBottomSheetCheckOutOrder extends StatefulWidget {
  const CreditCardBottomSheetCheckOutOrder({super.key});

  @override
  State<CreditCardBottomSheetCheckOutOrder> createState() =>
      _CreditCardBottomSheetCheckOutOrderState();
}

class _CreditCardBottomSheetCheckOutOrderState
    extends State<CreditCardBottomSheetCheckOutOrder> {
  final TextEditingController _textEditingControllerDelivery =
      TextEditingController();
  final TextEditingController _textEditingControllerPhoneNumber =
      TextEditingController();

  final TextEditingController _textEditingControllerCVV =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = MediaQuery.of(context).size.height;
    final halfScreenHeight = screenHeight / 2;
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: mediaQueryData.viewInsets,
      child: Container(
        color: Colors.transparent,
        height: halfScreenHeight * 1.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  Const.cardHolderName,
                                  style: Const.h1HeaderText,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color:
                                          Const.hexToColor(Const.editTextColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: SizedBox(
                                    width: screenSize.width * .8,
                                    height: 60,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Center(
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                Const.deliveryAddresshintText,
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          controller:
                                              _textEditingControllerDelivery,
                                          // onChanged: (value) {
                                          //   if (value.length > 10) {
                                          //     _textEditingController.text = '';
                                          //   }
                                          // },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  Const.cardNumber,
                                  style: Const.h1HeaderText,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color:
                                          Const.hexToColor(Const.editTextColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: SizedBox(
                                    width: screenSize.width * .8,
                                    height: 60,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Center(
                                        child: TextFormField(
                                          maxLength: 10,

                                          keyboardType: TextInputType.phone,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]'),
                                            ),
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                            // Allow only numbers
                                          ],
                                          decoration: const InputDecoration(
                                            counterText: '',
                                            border: InputBorder.none,
                                            hintText:
                                                Const.numbertocallhintText,
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          controller:
                                              _textEditingControllerPhoneNumber,
                                          // onChanged: (value) {
                                          //
                                          // },
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //
                                    SizedBox(
                                      width: screenSize.width * 0.3,
                                      child: const Text(
                                        Const.date,
                                        style: Const.h1HeaderText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.2,
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.3,
                                      child: const Text(
                                        Const.cvv,
                                        style: Const.h1HeaderText,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),

                                //Date and CVV Editext
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //
                                    GestureDetector(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Const.hexToColor(
                                                Const.editTextColor),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: SizedBox(
                                          width: screenSize.width * 0.3,
                                          height: 60,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Center(
                                              child: TextFormField(
                                                enabled: false,
                                                decoration:
                                                    const InputDecoration(
                                                  counterText: '',
                                                  border: InputBorder.none,
                                                  hintText: Const.dateHintText,
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                controller:
                                                    _textEditingControllerPhoneNumber,
                                                // onChanged: (value) {
                                                //
                                                // },
                                                textCapitalization:
                                                    TextCapitalization
                                                        .characters,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.2,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Const.hexToColor(
                                              Const.editTextColor),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: SizedBox(
                                        width: screenSize.width * 0.3,
                                        height: 60,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Center(
                                            child: TextFormField(
                                              maxLength: 3,
                                              keyboardType: TextInputType.phone,
                                              decoration: const InputDecoration(
                                                counterText: '',
                                                border: InputBorder.none,
                                                hintText: Const.cvvHintText,
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              controller:
                                                  _textEditingControllerCVV,
                                              // onChanged: (value) {
                                              //
                                              // },
                                              textCapitalization:
                                                  TextCapitalization.characters,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: Const.hexToColor(Const.appColor),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/completeorder');
                            },
                            child: Center(
                              child: _mCompleteOrder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ), // Replace YourContentWidget with your actual content
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Complete  Order Button
_mCompleteOrder() => Container(
      height: 60,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          Const.completeOder,
          style: TextStyle(
            fontSize: 15,
            color: Const.hexToColor(Const.appColor),
            fontFamily: "jost",
          ),
        ),
      ),
    );

////Delivery EditText
_mDeliveryAddressEdiText(
        Size screenSize, TextEditingController textEditingControllerDelivery) =>
    Container(
      decoration: BoxDecoration(
          color: Const.hexToColor(Const.editTextColor),
          borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: screenSize.width * .8,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Center(
            child: TextFormField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: Const.deliveryAddresshintText,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              controller: textEditingControllerDelivery,
              // onChanged: (value) {
              //   if (value.length > 10) {
              //     _textEditingController.text = '';
              //   }
              // },
            ),
          ),
        ),
      ),
    );

//Phone Number EditText
_mDeliveryPhoneNumberEdiText(Size screenSize,
        TextEditingController textEditingControllerPhoneNumber) =>
    Container(
      decoration: BoxDecoration(
          color: Const.hexToColor(Const.editTextColor),
          borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: screenSize.width * .8,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Center(
            child: TextFormField(
              maxLength: 10,

              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9]'),
                ),
                FilteringTextInputFormatter.digitsOnly // Allow only numbers
              ],
              decoration: const InputDecoration(
                counterText: '',
                border: InputBorder.none,
                hintText: Const.numbertocallhintText,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              controller: textEditingControllerPhoneNumber,
              // onChanged: (value) {
              //
              // },
              textCapitalization: TextCapitalization.characters,
            ),
          ),
        ),
      ),
    );
