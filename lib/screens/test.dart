import 'package:e_commerce_app/screens/home_page.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final keys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Form(
          key: keys,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 120,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 55,
                margin: EdgeInsets.only(left: 15, right: 15),
                child: TextFormField(
                  validator: (value){
                    if (value!.length<=5){
                      return 'error';
                    } else return null ;
                  },
                    decoration: InputDecoration(
                        labelText: 'Your Email',
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Color(0xff9098B1),
                        ),
                        border: OutlineInputBorder())),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (keys.currentState!.validate()){
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (BuildContext context) {
                                return HomePage();
                              }));
                        }
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Color(0xffFFFFFF)),
                      ),
                      style:
                      ElevatedButton.styleFrom(primary: Color(0xff40BFFF))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
