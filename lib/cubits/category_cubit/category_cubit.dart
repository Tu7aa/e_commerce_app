import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/repository/category.dart';
import 'package:meta/meta.dart';

import '../../model/category_repo_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  void getAllCategories() async {
    final listOfCategories = await CategoryRepository().getAllCategories();
    emit(CategorySuccess(listOfCategories));
  }
}


