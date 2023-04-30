import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/category_products_model.dart';
import '../../model/product_model.dart';
import '../../repository/category.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  void getProductOne ()async{
    final getMyProduct =await CategoryRepository().getProductOne();
    emit(ProductSuccess(getMyProduct));
  }
}
