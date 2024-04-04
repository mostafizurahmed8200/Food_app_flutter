import 'package:flutter/material.dart';

class Const {
  static const String assets = 'asset/img/';

//Basic Aseet
  static const String logo = '${assets}logo.png';
  static const String fruit1 = '${assets}fruit1.png';
  static const String fruit2 = '${assets}fruit2.png';

  //Home Screen Assets
  static const String menu = '${assets}menu.png';
  static const String cart = '${assets}shopping_cart.png';

  //Search
  static const String search = '${assets}search.png';
  static const String setting = '${assets}setting.png';

  //Card Asset
  static const String fav = '${assets}fav.png';
  static const String cancelbutton = '${assets}cancel.png';

  //Salad Asset-
  static const String salad1 = 'asset/img/salad/salad1.png';
  static const String salad2 = 'asset/img/salad/salad2.png';
  static const String salad3 = 'asset/img/salad/salad3.jpeg';
  static const String salad4 = 'asset/img/salad/salad4.jpeg';
  static const String salad5 = 'asset/img/salad/salad5.jpeg';
  static const String salad6 = 'asset/img/salad/salad6.jpeg';
  static const String salad7 = 'asset/img/salad/salad7.jpeg';
  static const String salad8 = 'asset/img/salad/salad8.jpeg';
  static const String salad9 = 'asset/img/salad/salad9.jpeg';
  static const String salad10 = 'asset/img/salad/salad10.jpeg';

//Colors--

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static const String appColor = '#FFA451';
  static const String addbtnColor = '#FFF2E7';
  static const String editTextColor = '#F3F1F1';
  static const String transparentButtonColor = '#FFF7F0';
  static const String transparentButton2Color = '#FEF0F0';

  //String Portion

  static const String saladCombo = 'Get The Freshest Fruit Salad Combo';
  static const String deliverInfo =
      'We deliver the best and freshest fruit salad in town. Order for a combo today!!!';
  static const String letsContinue = "Let's Continue";
  static const String firstName = "What is your first name ?";
  static const String hintText = 'Enter Your Name';
  static const String startOrder = 'Start Ordering';
  static const String addToBasket = 'Add to basket';
  static const String checkOutOrder = 'Checkout Order';

  static const String recommend = 'Recommended Combo';
  static const String searchHint = 'Search for fruit salad combo';

  static const String deliveryAddress = 'Delivery Address';
  static const String deliveryAddresshintText = 'India, Hyd, TS';
  static const String numbertocall = 'Number we can call you';
  static const String numbertocallhintText = '+91 8247355635';

  static const String payondelivery = 'Pay on delivery';
  static const String paywithCard = 'Pay with card';

  //Tabs
  static const String hottestTabs = 'Hottest';
  static const String popularTabs = 'Popular';
  static const String newComboTabs = 'New Combo';
  static const String topTabs = 'Top';

  //Add Details
  static const String onePack = 'One Pack Contains';
  static const String myBasket = 'My Basket';
  static const String onePackDetails =
      'Red Quinoa, Lime, Honey, Blueberries, Strawberries, Mango, Fresh mint.';
  static const String onePackDetails2 =
      'If you are looking for a new fruit salad to eat today, quinoa is the perfect brunch for you. make';

  //Text Style

  static const TextStyle headerText = TextStyle(
      fontSize: 20, fontFamily: "jost", fontWeight: FontWeight.normal);

  static const TextStyle bodyText = TextStyle(
      fontSize: 18,
      fontFamily: "jost",
      color: Colors.black,
      fontWeight: FontWeight.normal);

  static const TextStyle subheaderText = TextStyle(
    fontSize: 15,
    color: Colors.grey,
    fontFamily: "jost",
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 15,
    color: Colors.white,
    fontFamily: "jost",
  );

  static const TextStyle h1HeaderText = TextStyle(
    fontSize: 23,
    color: Colors.black,
    fontFamily: "jost",
  );

  static const TextStyle h11HeaderText = TextStyle(
    fontSize: 29,
    color: Colors.black,
    fontFamily: "jost",
  );

  static const TextStyle h11HeaderTextWhite = TextStyle(
    fontSize: 29,
    color: Colors.white,
    fontFamily: "jost",
  );

  static Container mContainer = Container(
    width: 100,
    height: 40,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(12)),
    child: const Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(Icons.arrow_back_ios),
        ),
        Text(
          "Go Back",
          style: TextStyle(fontFamily: 'jost', fontSize: 18),
        )
      ],
    ),
  );
}
