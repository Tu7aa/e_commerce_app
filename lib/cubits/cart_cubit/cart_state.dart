part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartSuccessful extends CartState {

  CartOne Cart;

  CartSuccessful(this.Cart);
}

class LoadingCart extends CartState {}
