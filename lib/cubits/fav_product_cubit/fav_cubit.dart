import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/category_products_model.dart';
import '../../model/product_model.dart';
import '../../repository/category.dart';

part 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit() : super(FavInitial());
  void getAllProduct(String CategoryName) async {
    final listCategories =
        await CategoryRepository().getProductsByCategory(CategoryName);
    emit(FavSuccess(listCategories));
  }
}
