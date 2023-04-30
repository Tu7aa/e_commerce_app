import 'package:dio/dio.dart';

import '../model/cart_model.dart';

class CartCategory {
  Future<CartOne?> cartProduct() async {
    try {
      final response = await Dio().get('https://dummyjson.com/carts/1');
      final cart = CartOne.fromJson(response.data);
      return cart;
    } on Exception catch (e) {
      print(e);

      return null;
    }
  }
}
