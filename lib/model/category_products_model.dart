// To parse this JSON data, do
//
//     final productOne = productOneFromJson(jsonString);

import 'dart:convert';

ProductOne productOneFromJson(String str) => ProductOne.fromJson(json.decode(str));

String productOneToJson(ProductOne data) => json.encode(data.toJson());

class ProductOne {
  ProductOne({
  required this.id,
  required this.title,
  required this.description,
  required this.price,
  required this.discountPercentage,
  required this.rating,
  required this.stock,
  required this.brand,
  required this.category,
  required this.thumbnail,
  required this.images,
  });

  int id;
  String title;
  String description;
  int price;
  double discountPercentage;
  double rating;
  int stock;
  String brand;
  String category;
  String thumbnail;
  List<String> images;

  factory ProductOne.fromJson(Map<String, dynamic> json) => ProductOne(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    discountPercentage: json["discountPercentage"].toDouble(),
    rating: json["rating"].toDouble(),
    stock: json["stock"],
    brand: json["brand"],
    category: json["category"],
    thumbnail: json["thumbnail"],
    images: List<String>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "price": price,
    "discountPercentage": discountPercentage,
    "rating": rating,
    "stock": stock,
    "brand": brand,
    "category": category,
    "thumbnail": thumbnail,
    "images": List<dynamic>.from(images.map((x) => x)),
  };
}
