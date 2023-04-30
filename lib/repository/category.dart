import 'package:dio/dio.dart';
import 'package:e_commerce_app/model/category_products_model.dart';
import 'package:flutter/foundation.dart';

import '../model/category_repo_model.dart';
import '../model/product_details.dart';
import '../model/product_model.dart';

class CategoryRepository {

  Future<List<CategoryRepoModel>> getAllCategories() async {
    final response =
        await Dio().get('https://api.escuelajs.co/api/v1/categories/');

    final listOfCategories = List<CategoryRepoModel>.from(
      response.data.map(
        (value) => CategoryRepoModel(
          id: value['id'],
          name: value['name'],
          image: value['image'],
        ),
      ),
    );
    return listOfCategories;
  }

  Future<List<Product>> getProductsByCategory(CategoryName) async {
    final response = await Dio().get('https://dummyjson.com/products/category/$CategoryName');
    final categoryProducts = Products.fromJson(response.data);
    return categoryProducts.products;
  }

  Future<ProductOne> getProductOne() async {
    final response = await Dio().get('https://dummyjson.com/products/1');
    final Product=ProductOne.fromJson(response.data);
    return Product;
  }
  Future<ProductOnee> getProductSngle( int productId)async{
    final response=await Dio().get('https://dummyjson.com/products/$productId');
    final OneProduct =ProductOnee.fromJson(response.data);
    return OneProduct;
  }
}
