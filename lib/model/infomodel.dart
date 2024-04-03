import '../assets/const.dart';

class InfoModel {
  String saladImage = "";
  String saladName = "";
  String saladPrice = "";

  InfoModel({
    required this.saladImage,
    required this.saladName,
    required this.saladPrice,
  });
}

class MyInfoModel {
  static List<InfoModel> myInfoAllList = [
    InfoModel(
        saladImage: Const.salad1,
        saladName: "Honey-Lime Combo",
        saladPrice: '2000'),
    InfoModel(
        saladImage: Const.salad2,
        saladName: "Berry-Mango Combo",
        saladPrice: '2000'),
  ];
}
