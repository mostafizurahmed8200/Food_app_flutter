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

  //Salad Asset-
  static const String salad1 = '${assets}salad1.png';
  static const String salad2 = '${assets}salad2.png';

//Colors--

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static const String appColor = '#FFA451';
  static const String editTextColor = '#F3F1F1';

  //String Portion

  static const String saladCombo = 'Get The Freshest Fruit Salad Combo';
  static const String deliverInfo =
      'We deliver the best and freshest fruit salad in town. Order for a combo today!!!';
  static const String letsContinue = "Let's Continue";
  static const String firstName = "What is your first name ?";
  static const String hintText = 'A H M E D';
  static const String startOrder = 'Start Ordering';

  static const String recommend = 'Recommended Combo';
  static const String searchHint = 'Search for fruit salad combo';

  //Tabs
  static const String hottestTabs = 'Hottest';
  static const String popularTabs = 'Popular';
  static const String newComboTabs = 'New Combo';
  static const String topTabs = 'Top';

  //Text Style

  static const TextStyle headerText = TextStyle(
      fontSize: 20, fontFamily: "jost", fontWeight: FontWeight.normal);

  static const TextStyle sub_headerText = TextStyle(
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
}
