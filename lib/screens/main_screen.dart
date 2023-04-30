import 'package:e_commerce_app/screens/account_page.dart';
import 'package:e_commerce_app/screens/cart_page.dart';
import 'package:e_commerce_app/screens/home_page.dart';
import 'package:e_commerce_app/screens/offers_page.dart';
import 'package:e_commerce_app/screens/search_page.dart';
import 'package:flutter/material.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  List<Widget> listOfScreens = [
    HomePage(),
    SearchPage(),
    CartPage(),
    OffersPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer_outlined),
            label: "Offers",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Account",
          ),
        ],
      ),

      body: listOfScreens[currentIndex],
    );
  }
}
