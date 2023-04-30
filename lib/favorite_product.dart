import 'package:e_commerce_app/screens/product_page.dart';
import 'package:e_commerce_app/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import 'cubits/fav_product_cubit/fav_cubit.dart';
import 'model/category_model.dart';

class FavoriteProduct extends StatefulWidget {
  String CategoryName;

  FavoriteProduct({Key? key, required this.CategoryName}) : super(key: key);

  @override
  State<FavoriteProduct> createState() => _FavoriteProductState();
}

class _FavoriteProductState extends State<FavoriteProduct> {
  List<MyProducts> listOfCategory = [
    MyProducts(
      image: 'assets/images/Product Image.png',
      title: 'FS - Nike Air Max 270 React...',
      price: 299,
      discount: '24%',
    ),
    MyProducts(
      image: 'assets/images/image.png',
      title: 'FS - Nike Air Max 270 React...',
      price: 299,
      discount: '24%',
    ),
    MyProducts(
      image: 'assets/images/image 55.png',
      title: 'FS - Nike Air Max 270 React...',
      price: 299,
      discount: '24%',
    ),
    MyProducts(
        image: 'assets/images/image Product (4).png',
        price: 299,
        title: 'Nike Air Max 270 React ENG',
        discount: '24%')
  ];
  double values = 3.5;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavCubit()..getAllProduct(widget.CategoryName),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            '${widget.CategoryName} category',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  height: 500,
                  child: BlocBuilder<FavCubit, FavState>(
                    builder: (context, state) {
                      if (state is FavSuccess) {
                        final listCategories = state.products;
                        return Container(
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: listCategories.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.only(left: 13, right: 13),
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        Border.all(color: Color(0xff9098B1))),
                                child: GestureDetector(
                                  onTap: () { Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return ProductScreen(productId:listCategories[index].id );
                                          }));},
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 14, right: 12, top: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          listCategories[index].thumbnail,
                                          height: 110,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          listCategories[index].title,
                                          style: TextStyle(
                                              color: AppColor.darkColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(left: 10),
                                              child: RatingStars(
                                                value: values,
                                                onValueChanged: (v) {
                                                  //
                                                  setState(() {
                                                    values = v;
                                                  });
                                                },
                                                starBuilder: (index, color) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: color,
                                                ),
                                                starCount: 5,
                                                valueLabelColor:
                                                    const Color(0xff9b9b9b),
                                                valueLabelRadius: 5,
                                                maxValue: 5,
                                                starSpacing: 1,
                                                maxValueVisibility: false,
                                                valueLabelVisibility: false,
                                                animationDuration: Duration(
                                                    milliseconds: 1000),
                                                starOffColor:
                                                    const Color(0xffe7e8ea),
                                                starColor: Colors.yellow,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 7),
                                        Text(
                                            '\$ ${listCategories[index].price}',
                                            style: TextStyle(
                                                color:
                                                    AppColor.primaryColor)),
                                        Row(
                                          children: [
                                            Text(
                                              '\$ ${listCategories[index].price}',
                                              style: TextStyle(
                                                decoration: TextDecoration
                                                    .lineThrough,
                                                color: AppColor.greyColor,
                                              ),
                                            ),
                                            SizedBox(width: 7),
                                            Text(
                                              '${listCategories[index].discountPercentage} off',
                                              style: TextStyle(
                                                  color: AppColor.redColor,
                                                  fontWeight:
                                                      FontWeight.bold),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
