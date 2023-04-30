import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/cart_model.dart';
import '../../repository/cart.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  void getTotalCart(var id) async {
    emit(LoadingCart());
    final cart = await CartCategory().cartProduct();

    emit(CartSuccessful(cart!));
  }
}
