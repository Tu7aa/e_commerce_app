import 'dart:convert';

CartOne cartOneFromJson(String str) => CartOne.fromJson(json.decode(str));

String cartOneToJson(CartOne data) => json.encode(data.toJson());

class CartOne {
  CartOne({
   required this.id,
   required this.products,
   required this.total,
   required this.discountedTotal,
   required this.userId,
   required this.totalProducts,
   required this.totalQuantity,
  });

  int id;
  List<Product> products;
  int total;
  int discountedTotal;
  int userId;
  int totalProducts;
  int totalQuantity;

  factory CartOne.fromJson(Map<String, dynamic> json) => CartOne(
        id: json["id"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        total: json["total"],
        discountedTotal: json["discountedTotal"],
        userId: json["userId"],
        totalProducts: json["totalProducts"],
        totalQuantity: json["totalQuantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "total": total,
        "discountedTotal": discountedTotal,
        "userId": userId,
        "totalProducts": totalProducts,
        "totalQuantity": totalQuantity,
      };
}

class Product {
  Product({
  required  this.id,
  required  this.title,
  required  this.price,
  required  this.quantity,
  required  this.total,
  required  this.discountPercentage,
  required  this.discountedPrice,
  });

  int id;
  String title;
  int price;
  int quantity;
  int total;
  double discountPercentage;
  int discountedPrice;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        quantity: json["quantity"],
        total: json["total"],
        discountPercentage: json["discountPercentage"].toDouble(),
        discountedPrice: json["discountedPrice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "quantity": quantity,
        "total": total,
        "discountPercentage": discountPercentage,
        "discountedPrice": discountedPrice,
      };
}
