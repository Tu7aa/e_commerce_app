part of 'single_product_cubit.dart';

@immutable
abstract class SingleProductState {}

class SingleProductInitial extends SingleProductState {}

class SingleProductSuccess extends SingleProductState {
  ProductOnee theProductt ;
    SingleProductSuccess(this.theProductt);

}