class SaladBasketSqlModel {
  String? saladImage;
  String? saladName;
  String? saladPack;
  String? saladPrice;

  SaladBasketSqlModel(
      {required this.saladImage,
      required this.saladName,
      required this.saladPack,
      required this.saladPrice});

  Map<String, dynamic> toMap() {
    return {
      'saladImage': saladImage,
      'saladName': saladName,
      'saladPack': saladPack,
      'saladPrice': saladPrice,
    };
  }
}
