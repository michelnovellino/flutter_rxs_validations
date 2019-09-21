import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String id;
  String title;
  double price;
  bool avaliable;
  String photoUrl;

  ProductModel({
    this.id,
    this.title = '',
    this.price = 0.0,
    this.avaliable = true,
    this.photoUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble(),
        avaliable: json["avaliable"],
        photoUrl: json["photo_url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price.toDouble(),
        "avaliable": avaliable,
        "photo_url": photoUrl,
      };
}
