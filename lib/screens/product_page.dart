import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/model/selection_model.dart';
import 'package:e_commerce_app/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import '../cubits/single_product_cubit/single_product_cubit.dart';
import 'cart_page.dart';

class ProductScreen extends StatefulWidget {
  int productId;

  ProductScreen({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}



class _ProductScreenState extends State<ProductScreen> {
  List<SelectModel> SelectSize = [
    SelectModel(number: 6),
    SelectModel(number: 6.5),
    SelectModel(number: 7),
    SelectModel(number: 7.5),
    SelectModel(number: 8),
    SelectModel(number: 8.5),
  ];
  List<SelectColor> SelectColors = [
    SelectColor(color: Colors.amber),
    SelectColor(color: Colors.blueAccent),
    SelectColor(color: Colors.redAccent),
    SelectColor(color: Colors.green),
    SelectColor(color: Colors.blue),
    SelectColor(color: Colors.black),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => SingleProductCubit()..oneProduct(widget.productId),
        child: BlocBuilder<SingleProductCubit, SingleProductState>(
          builder: (context, state) {
            if (state is SingleProductSuccess) {
              var ProductOnee = state.theProductt;
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: AppColor.greyColor,
                              )),
                          Text(
                            '${ProductOnee.title}',
                            style: TextStyle(
                                color: AppColor.darkColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                               ),
                          ),
                          SizedBox(width: 100),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.search_outlined,
                                color: AppColor.greyColor,
                                size: 30,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.menu_outlined,
                                color: AppColor.greyColor,
                                size: 30,
                              )),
                        ],
                      ),
                      Container(
                        child: CarouselSlider.builder(
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: false,
                            aspectRatio: 2.2,
                          ),
                          itemCount: ProductOnee.images.length,
                          itemBuilder:
                              (BuildContext context, int index, int realIndex) {
                            return Container(
                              child: Image.network(ProductOnee.images[index]),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              '${ProductOnee.title}',
                              style: TextStyle(
                                  color: AppColor.darkColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  fontFamily: 'Poppins'),
                            ),
                          ),
                          SizedBox(width: 180),
                          Icon(
                            Icons.favorite_border_outlined,
                            color: AppColor.greyColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: RatingStars(
                              value:ProductOnee.rating ,
                              starBuilder: (index, color) => Icon(
                                Icons.star,
                                color: color,
                              ),

                              starCount: 5,
                              valueLabelColor: const Color(0xff9b9b9b),
                              valueLabelTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.0),
                              valueLabelRadius: 10,
                              maxValue: 5,
                              starSpacing: 2,
                              maxValueVisibility: false,
                              valueLabelVisibility: false,
                              animationDuration: Duration(milliseconds: 1000),
                              valueLabelPadding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 8),
                              valueLabelMargin: const EdgeInsets.only(right: 8),
                              starOffColor: const Color(0xffe7e8ea),
                              starColor: Colors.yellow,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                Text(
                                  '\$ ${ProductOnee.price}',
                                  style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Select Size",
                                  style: TextStyle(
                                      color: AppColor.darkColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: SelectSize.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: CircleAvatar(
                                      radius: 31,
                                      backgroundColor: Colors.grey,
                                      child: CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.white,
                                          child: Text(
                                            '${ProductOnee.stock}',
                                            style: TextStyle(
                                                color: AppColor.darkColor,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                Text(
                                  "Select Color",
                                  style: TextStyle(
                                      color: AppColor.darkColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 80,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: SelectColors.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.grey,
                                        child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor:
                                                SelectColors[index].color),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Specification',
                                  style: TextStyle(
                                      color: AppColor.darkColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10, left: 10),
                            child: Text('Shown:',
                                style: TextStyle(
                                  color: AppColor.darkColor,
                                  fontSize: 20,
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10, left: 10),
                            child: Text(
                              'Laser',
                              style: TextStyle(
                                  color: AppColor.greyColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Blue/Anthracite\n / Watermelon ,white',
                                style: TextStyle(
                                    color: AppColor.greyColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10, left: 10),
                            child: Text('Style:',
                                style: TextStyle(
                                  color: AppColor.darkColor,
                                  fontSize: 20,
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10, left: 10),
                            child: Text(
                              'CD0113-400',
                              style: TextStyle(
                                  color: AppColor.greyColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        child: Text(
                          '${ProductOnee.description}',
                          style: TextStyle(
                            color: AppColor.greyColor,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10, left: 10),
                            child: Text('Review Product',
                                style: TextStyle(
                                    color: AppColor.darkColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w900)),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'See More',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ))),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: RatingStars(
                              value: ProductOnee.rating,
                              onValueChanged: (v) {
                              },
                              starBuilder: (index, color) => Icon(
                                Icons.star,
                                color: color,
                              ),
                              starCount: 5,
                              valueLabelColor: const Color(0xff9b9b9b),
                              valueLabelTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.0),
                              valueLabelRadius: 10,
                              maxValue: 5,
                              starSpacing: 2,
                              maxValueVisibility: false,
                              valueLabelVisibility: false,
                              animationDuration: Duration(milliseconds: 1000),
                              valueLabelPadding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 8),
                              valueLabelMargin: const EdgeInsets.only(right: 8),
                              starOffColor: const Color(0xffe7e8ea),
                              starColor: Colors.yellow,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            '4.5 ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColor.greyColor),
                          ),
                          Text(
                            '(5 Review)',
                            style: TextStyle(color: AppColor.greyColor),
                          )
                        ],
                      ),
                      SizedBox(height: 15),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/images/Profile Picture.png'),
                              radius: 33,
                            ),
                            SizedBox(width: 15),
                            Column(
                              children: [
                                Text(
                                  'James Lawson',
                                  style: TextStyle(
                                      color: AppColor.darkColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  child: RatingStars(
                                    value: ProductOnee.rating,
                                    onValueChanged: (v) {

                                    },
                                    starBuilder: (index, color) => Icon(
                                      Icons.star,
                                      color: color,
                                    ),
                                    starCount: 5,
                                    valueLabelColor: const Color(0xff9b9b9b),
                                    valueLabelTextStyle: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12.0),
                                    valueLabelRadius: 10,
                                    maxValue: 5,
                                    starSpacing: 2,
                                    maxValueVisibility: false,
                                    valueLabelVisibility: false,
                                    animationDuration:
                                        Duration(milliseconds: 1000),
                                    valueLabelPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 1, horizontal: 8),
                                    valueLabelMargin:
                                        const EdgeInsets.only(right: 8),
                                    starOffColor: const Color(0xffe7e8ea),
                                    starColor: Colors.yellow,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        child: Text(
                          '${ProductOnee.description}',
                          style: TextStyle(
                            color: AppColor.greyColor,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Image.network(ProductOnee.images[0],width: 80,),
                            SizedBox(width: 20),
                            Image.network(ProductOnee.images[1],width: 80,),
                            SizedBox(width: 20),
                            Image.network(ProductOnee.images[2],width: 80,),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              'December 10, 2016',
                              style: TextStyle(
                                  fontSize: 14, color: AppColor.greyColor),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              'You Might Also Like',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: AppColor.darkColor,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        height: 200,
                        child: ListView.builder(
                          itemCount: ProductOnee.images.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Color(0xff9098B1))),
                              child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 14, right: 12, top: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                       Image.network(ProductOnee.images[index]),
                                        SizedBox(height: 4),
                                        Text(
                                          ProductOnee.title,
                                          style: TextStyle(
                                              color: AppColor.darkColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                        SizedBox(height: 7),
                                        Text(
                                            '\$ ${ProductOnee.price}',
                                            style: TextStyle(
                                                color: AppColor.primaryColor)),
                                        Row(
                                          children: [
                                            Text('\$534,33',
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: AppColor.greyColor)),
                                            SizedBox(width: 7),
                                            Text(
                                              '${ProductOnee.discountPercentage} off',
                                              style: TextStyle(
                                                  color: AppColor.redColor,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => CartPage()),
                                );
                              },
                              child: Text(
                                'Add To Cart',
                                style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: AppColor.primaryColor)),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
