class SaladBasketSqlModel {
  String? saladImage;
  String? saladName;
  String? saladPack;
  String? saladPrice;
  int? id;

  SaladBasketSqlModel(
      {required this.saladImage,
      required this.saladName,
      required this.saladPack,
      required this.saladPrice,
      this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'saladImage': saladImage,
      'saladName': saladName,
      'saladPack': saladPack,
      'saladPrice': saladPrice,
    };
  }
}
