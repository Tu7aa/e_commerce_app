import 'package:dio/dio.dart';
import 'package:e_commerce_app/screens/main_screen.dart';
import 'package:e_commerce_app/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObscureText = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    Image.asset(
                      'assets/images/Vector.png',
                      height: 72,
                      width: 72,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Welcome to Lafyuu",
                      style: TextStyle(
                          fontSize: 25,
                          color: Color(0xff223263),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Sign in to continue",
                      style: TextStyle(fontSize: 15, color: Color(0xff9098B1)),
                    ),
                    SizedBox(height: 28),
                    Container(
                      margin: EdgeInsets.only(left: 14, right: 14),
                      child: TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value!.length <= 5) {
                              return "Please enter Email again ";
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Your Email',
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Color(0xff9098B1),
                              ),
                              border: OutlineInputBorder())),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 14, right: 14),
                      child: TextFormField(
                          validator: (value) {
                            if (value!.length <= 5) {
                              return 'Please enter Password Again';
                            } else
                              return null;
                          },
                          controller: passwordController,
                          obscureText: isObscureText,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock_outline,
                                  color: Color(0xff9098B1)),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isObscureText = !isObscureText;
                                  });
                                },
                                icon: isObscureText
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                              ),
                              border: OutlineInputBorder())),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            print(emailController.text);
                            print(passwordController.text);
                            if (_formKey.currentState!.validate()) {
                              login();
                            }
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Color(0xffFFFFFF)),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xff40BFFF))),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 15),
                        Text(
                          'or',
                          style: TextStyle(
                              fontSize: 21,
                              color: Color(0xff9098B1),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 15),
                        Container(
                          width: 100,
                          child: Divider(color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Color(0xffE5E5E5))),
                        child: MaterialButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/images/google-reviews-250x250.png",
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(width: 100),
                              Text(
                                "Login with Google",
                                style: TextStyle(
                                    color: Color(0xff9098B1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Color(0xffE5E5E5))),
                      child: TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.facebook),
                          label: Text(
                            'Login With Facebook',
                            style: TextStyle(color: Color(0xff9098B1)),
                          )),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Forget Password ?",
                      style: TextStyle(color: Color(0XFF40BFFF)),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?'),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                              return Register();
                            }));
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(color: Color(0xff40BFFF)),
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    try {
      final response =
          await Dio().post("https://api.escuelajs.co/api/v1/auth/login", data: {
        "email": emailController.text,
        "password": passwordController.text,
      });
      print('data is : ${response.data['access_token']}');

      final accessToken = response.data['access_token'];

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('access_token', accessToken);
      print('my access token is :$accessToken');

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
        return MainPage();
      }));
    } on DioError catch (e) {
      print("This is an error :${e.response}");
      if (e.response!.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('You Should Enter Valid Email And Password'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
}
