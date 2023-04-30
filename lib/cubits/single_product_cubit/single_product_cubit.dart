import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/category_products_model.dart';
import '../../model/product_details.dart';
import '../../repository/category.dart';
import '../product_cubit/product_cubit.dart';

part 'single_product_state.dart';

class SingleProductCubit extends Cubit<SingleProductState> {
  SingleProductCubit() : super(SingleProductInitial());
  void oneProduct (int productId) async {
     final productSingle = await  CategoryRepository().getProductSngle(productId);
    emit(SingleProductSuccess(productSingle));
  }
}
