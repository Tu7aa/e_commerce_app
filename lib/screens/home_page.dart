import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_commerce_app/cubits/category_cubit/category_cubit.dart';
import 'package:e_commerce_app/favorite_product.dart';
import 'package:e_commerce_app/model/category_model.dart';
import 'package:e_commerce_app/model/mega_sale_model.dart';
import 'package:e_commerce_app/repository/product.dart';
import 'package:e_commerce_app/screens/product_page.dart';
import 'package:e_commerce_app/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/product_repo_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<MegaSaleModel> MegaSaleProduct = [
    MegaSaleModel(
      image: 'assets/images/image.png',
      title: 'FS - Nike Air Max 270 React...',
      price: 299,
      discount: '24%',
    ),
    MegaSaleModel(
      image: 'assets/images/image Product (4).png',
      title: 'FS - Nike Air Max 270 React...',
      price: 299,
      discount: '24%',
    ),
    MegaSaleModel(
      image: 'assets/images/image 55.png',
      title: 'FS - Nike Air Max 270 React...',
      price: 299,
      discount: '24%',
    ),
  ];

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
  bool InternetConnected = false;

  @override
  void initState() {
    super.initState();
    final subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          InternetConnected = false;
        });
      } else {
        setState(() {
          InternetConnected = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (InternetConnected = false) {
      return Center(
        child: Icon(Icons.signal_wifi_connected_no_internet_4),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => CategoryCubit()..getAllCategories(),

        child: SafeArea(
          child: ListView(children: [
            Column(
              children: [
                SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.all(12),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Search Product',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              prefixIcon: Icon(Icons.search,
                                  color: AppColor.primaryColor)),
                        )),
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border_outlined,
                        color: AppColor.greyColor,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.notifications_none_outlined,
                      color: AppColor.greyColor,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                _sliderWidget(),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10, left: 10),
                      child: Text('Category',
                          style: TextStyle(
                              color: AppColor.darkColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w900)),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: TextButton(
                            onPressed: () {}, child: Text('More Category'))),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (BuildContext context, state) {
                    if (state is CategorySuccess) {
                      final listOfCategories = state.list;
                      return Container(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: listOfCategories.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => FavoriteProduct(
                                          CategoryName:
                                              listOfCategories[index].name)),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundImage: NetworkImage(
                                          listOfCategories[index].image),
                                    ),
                                    SizedBox(height: 10),
                                    Text(listOfCategories[index].name),
                                  ],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Text('Flash Sale',
                          style: TextStyle(
                              color: AppColor.darkColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: TextButton(
                            onPressed: () {}, child: Text('See More')))
                  ],
                ),
                FutureBuilder<List<ProductRepoModel>>(
                    future: ProductRepository().getAllProducts(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<ProductRepoModel>> snapshot) {

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        final listOfProducts = snapshot.data;

                        return Container(
                          margin: EdgeInsets.only(left: 15),
                          height: 200,
                          child: ListView.builder(
                            itemCount: listOfProducts!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, index) {
                              return Container(
                                margin: EdgeInsets.only(left: 16, right: 16),
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        Border.all(color: Color(0xff9098B1))),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => ProductScreen(
                                                productId:
                                                listOfProducts[index].id)),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 14, right: 12, top: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                              listOfProducts[index].image),
                                          SizedBox(height: 4),
                                          Text(
                                            listOfProducts[index].title,
                                            style: TextStyle(
                                                color: AppColor.darkColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                          SizedBox(height: 7),
                                          Text(
                                              '\$ ${listOfProducts[index].price}',
                                              style: TextStyle(
                                                  color:
                                                      AppColor.primaryColor)),
                                          Row(
                                            children: [
                                              Text('\$534,33',
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color:
                                                          AppColor.greyColor)),
                                              SizedBox(width: 7),
                                              Text(
                                                '${listOfProducts[index].discount} off',
                                                style: TextStyle(
                                                    color: AppColor.redColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              );
                            },
                          ),
                        );
                      }
                      return SizedBox();
                    }),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          'Mega Sale',
                          style: TextStyle(
                              color: AppColor.darkColor,
                              fontWeight: FontWeight.bold),
                        )),
                    TextButton(onPressed: () {}, child: Text('See More'))
                  ],
                ),
                _megaSale(),
                SizedBox(
                  height: 10,
                ),
                _stack(),
                SizedBox(height: 15),
                _listOfCategory(),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Stack _stack() {
    return Stack(
      children: [
        Container(child: Image.asset('assets/images/image 51.png')),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 50),
          child: Text(
            'Recommended ',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 85),
          child: Text(
            'Product',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 135),
          child: Text(
            'We recommend the best for you',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Container _listOfCategory() {
    return Container(
      margin: EdgeInsets.only(left: 15),
      height: 500,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: listOfCategory.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Color(0xff9098B1))),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(left: 14, right: 12, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      listOfCategory[index].image!,
                      height: 110,
                    ),
                    SizedBox(height: 4),
                    Text(
                      listOfCategory[index].title!,
                      style: TextStyle(
                          color: AppColor.darkColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                    SizedBox(height: 7),
                    Text('\$ ${listOfCategory[index].price}',
                        style: TextStyle(color: AppColor.primaryColor)),
                    Row(
                      children: [
                        Text(
                          '\$534,33',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: AppColor.greyColor,
                          ),
                        ),
                        SizedBox(width: 7),
                        Text(
                          '${listOfCategory[index].discount} off',
                          style: TextStyle(
                              color: AppColor.redColor,
                              fontWeight: FontWeight.bold),
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

  Container _megaSale() {
    return Container(
      margin: EdgeInsets.only(left: 15),
      height: 200,
      child: ListView.builder(
        itemCount: MegaSaleProduct.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Color(0xff9098B1))),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(left: 14, right: 12, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      MegaSaleProduct[index].image!,
                      height: 110,
                    ),
                    SizedBox(height: 4),
                    Text(
                      MegaSaleProduct[index].title!,
                      style: TextStyle(
                          color: AppColor.darkColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                    SizedBox(height: 7),
                    Text('\$ ${MegaSaleProduct[index].price}',
                        style: TextStyle(color: AppColor.primaryColor)),
                    Row(
                      children: [
                        Text(
                          '\$534,33',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: AppColor.greyColor,
                          ),
                        ),
                        SizedBox(width: 7),
                        Text(
                          '${MegaSaleProduct[index].discount} off',
                          style: TextStyle(
                              color: AppColor.redColor,
                              fontWeight: FontWeight.bold),
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

  Container _sliderWidget() {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: false,
          aspectRatio: 2.2,
        ),
        items: [
          Image.asset('assets/images/Promotion Image.png'),
          Image.asset('assets/images/Product Image.png'),
          Image.asset("assets/images/image 51.png")
        ],
      ),
    );
  }
}
