import 'package:e_commerce_app/model/product_repo_model.dart';
import 'package:dio/dio.dart';

class ProductRepository {
  Future<List<ProductRepoModel>> getAllProducts() async {
    final response = await Dio().get('https://dummyjson.com/products');

    print('listData ${response.data}');
    final listOfProducts = List<ProductRepoModel>.from(
      response.data['products'].map(
        (value) => ProductRepoModel(
          image: value['thumbnail'],
          title: value['title'],
          price: value['price'],
          discount: value['discountPercentage'],
          id: value['id'],
        ),
      ),
    );
    print('listProduct ${listOfProducts}');

    return listOfProducts;
  }
}
