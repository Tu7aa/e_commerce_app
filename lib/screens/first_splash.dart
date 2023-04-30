import 'dart:async';

import 'package:e_commerce_app/screens/home_page.dart';
import 'package:e_commerce_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstSplash extends StatefulWidget {
  const FirstSplash({Key? key}) : super(key: key);

  @override
  State<FirstSplash> createState() => _FirstSplashState();
}

class _FirstSplashState extends State<FirstSplash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), navigator);
  }

  void navigator() async {
    final prefs = await SharedPreferences.getInstance();
    final access = await prefs.get('access_token');
    if (access == null) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
        return LoginPage();
      }));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
        return HomePage();
      }));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Image.asset('assets/images/single icon White.png'),
      ),
    );
  }
}
