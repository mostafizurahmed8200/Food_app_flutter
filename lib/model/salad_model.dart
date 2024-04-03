import '../assets/const.dart';

class SaladModel {
  String saladImage = "";
  String saladName = "";
  String saladPrice = "";

  SaladModel({
    required this.saladImage,
    required this.saladName,
    required this.saladPrice,
  });
}

class MySaladModel {
  static List<SaladModel> myInfoAllList = [
    SaladModel(
        saladImage: Const.salad1,
        saladName: "Honey-Lime Combo",
        saladPrice: '2000'),
    SaladModel(
        saladImage: Const.salad2,
        saladName: "Berry-Mango Combo",
        saladPrice: '4000'),
    SaladModel(
        saladImage: Const.salad3,
        saladName: "Berry-Mango Combo",
        saladPrice: '500'),
    SaladModel(
        saladImage: Const.salad4,
        saladName: "Berry-Mango Combo",
        saladPrice: '3000'),
    SaladModel(
        saladImage: Const.salad5,
        saladName: "Berry-Mango Combo",
        saladPrice: '200'),
    SaladModel(
        saladImage: Const.salad6,
        saladName: "Berry-Mango Combo",
        saladPrice: '100'),
    SaladModel(
        saladImage: Const.salad7,
        saladName: "Berry-Mango Combo",
        saladPrice: '900'),
    SaladModel(
        saladImage: Const.salad8,
        saladName: "Berry-Mango Combo",
        saladPrice: '2000'),
    SaladModel(
        saladImage: Const.salad9,
        saladName: "Berry-Mango Combo",
        saladPrice: '2000'),
    SaladModel(
        saladImage: Const.salad10,
        saladName: "Berry-Mango Combo",
        saladPrice: '2000'),
  ];
}
