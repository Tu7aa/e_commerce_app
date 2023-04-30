part of 'fav_cubit.dart';

@immutable
abstract class FavState {}

class FavInitial extends FavState {}

class FavSuccess extends FavState {
  List<Product> products;
  FavSuccess(this.products);
}

