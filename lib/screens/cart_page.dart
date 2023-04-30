import 'package:e_commerce_app/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/cart_cubit/cart_cubit.dart';

class CartPage extends StatefulWidget {

  CartPage({Key? key, }) : super(key: key);

  @override
  State<CartPage> createState() => _CardInCartModelState();
}

class _CardInCartModelState extends State<CartPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          'Your Cart',
          style: TextStyle(
              color: AppColor.darkColor,
              fontWeight: FontWeight.bold,
              fontSize: 23),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => CartCubit()
            ..getTotalCart(widget.key),
          child: Column(
            children: [
              SizedBox(height: 15),
              SafeArea(
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    if (state is LoadingCart) {
                      return CircularProgressIndicator();
                    }
                    if (state is CartSuccessful) {
                      var Carts = state.Cart.products;
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: Carts.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              height: 104,
                              width: 343,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 215, 221, 237)),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              child: Row(children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Image.asset(
                                    "assets/images/Photo.png",
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Container(
                                  width: 262,
                                  // width: MediaQuery.of(context).size.width,

                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 168,
                                            child: Text(
                                              "${Carts[index].title}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12,
                                                //  height: 56,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset(
                                            'assets/images/love.png',
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset('assets/images/Trash.png')
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "\$ ${Carts[index].price}",
                                            style: TextStyle(
                                              color: AppColor.primaryColor,
                                            ),
                                          ),
                                          Container(
                                            width: 120,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color.fromARGB(
                                                      255, 215, 221, 237)),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 40,
                                                  child: IconButton(
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {
                                                      Carts[index].quantity--;
                                                    },
                                                    icon: Icon(
                                                      Icons.remove,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 40,
                                                  color: Color(0xffEBF0FF),
                                                  child: Center(
                                                    child: Text(
                                                      "${Carts[index].quantity}",
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 31,
                                                  child: IconButton(
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {
                                                      Carts[index].quantity++;
                                                    },
                                                    icon: Icon(
                                                      Icons.add,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            );
                          });
                    }

                    return Text(
                      'يالهوووووووووووووووي',
                      style: TextStyle(
                          color: AppColor.darkColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    );
                  },
                ),
              ),
              SizedBox(height: 25),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 70,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Coupon Code ',
                    suffixIcon: Container(
                      height: 70,
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff40BFFF)),
                        onPressed: () {},
                        child: Text(
                          "Apply",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state is CartSuccessful) {
                    var Card = state.Cart;
                    return Container(
                      width: 450,
                      height: 240,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: Colors.grey)),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Items',
                                  style: TextStyle(
                                      color: AppColor.greyColor, fontSize: 19),
                                ),
                                Text(
                                  '\$ ${Card.totalProducts}',
                                  style: TextStyle(
                                      color: AppColor.darkColor, fontSize: 19),
                                )
                              ],
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 20),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Shaping',
                                  style: TextStyle(
                                      color: AppColor.greyColor, fontSize: 19),
                                ),
                                Text(
                                  '\$40.00',
                                  style: TextStyle(
                                      color: AppColor.darkColor, fontSize: 19),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Import charges',
                                  style: TextStyle(
                                      color: AppColor.greyColor, fontSize: 19),
                                ),
                                Text(
                                  '\$128.00',
                                  style: TextStyle(
                                      color: AppColor.darkColor, fontSize: 19),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Image.asset(
                            'assets/images/Line 39.png',
                            color: Colors.grey,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Price',
                                  style: TextStyle(
                                      color: AppColor.darkColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                                Text(
                                  '\$ ${Card.total}',
                                  style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                )
                              ],
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 20),
                          ),
                        ],
                      ),
                    );
                  }
                  return Text(
                    'يالهوووووووووووووووي',
                    style: TextStyle(
                        color: AppColor.darkColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  );
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                height: 70,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color(0xff40BFFF)),
                    onPressed: () {},
                    child: Container(
                      child: Text(
                        'Check Out',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
