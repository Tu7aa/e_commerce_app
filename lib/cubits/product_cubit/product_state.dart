part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductSuccess extends ProductState{
  ProductOne Product;
  ProductSuccess(this.Product);
}