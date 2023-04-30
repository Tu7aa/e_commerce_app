import 'package:e_commerce_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isObscureText = true;
  bool isObscureTextTwo = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController secondPasswordController = TextEditingController();
  final FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: FormKey,
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  Image.asset(
                    'assets/images/Vector.png',
                    height: 72,
                    width: 72,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Let\'s Get Started",
                    style: TextStyle(
                        fontSize: 25,
                        color: Color(0xff223263),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Create an new account",
                    style: TextStyle(color: Color(0xff9098B1)),
                  ),
                  SizedBox(height: 28),
                  Container(
                    height: 55,
                    margin: EdgeInsets.only(left: 14, right: 14),
                    child: TextFormField(
                        validator: (value) {
                          if (value!.length <= 5) {
                            return 'error';
                          } else
                            return null;
                        },
                        controller: nameController,
                        decoration: InputDecoration(
                            labelText: 'Full Name',
                            prefixIcon: Icon(
                              Icons.person_rounded,
                              color: Color(0xff9098B1),
                            ),
                            border: OutlineInputBorder())),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 55,
                    margin: EdgeInsets.only(left: 14, right: 14),
                    child: TextFormField(
                        validator: (value) {
                          if (value!.length <= 5) {
                            return 'error';
                          } else
                            return null;
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                            labelText: 'Your Email',
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Color(0xff9098B1),
                            ),
                            border: OutlineInputBorder())),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 55,
                    margin: EdgeInsets.only(left: 14, right: 14),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.length <= 5) {
                          return 'error';
                        } else
                          return null;
                      },
                      controller: passwordController,
                      obscureText: isObscureText,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Color(0xff9098B1),
                        ),
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
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 55,
                    margin: EdgeInsets.only(left: 14, right: 14),
                    child: TextFormField(
                        validator: (value) {
                          if (value!.length <= 5) {
                            return 'error';
                          } else
                            return null;
                        },
                        controller: secondPasswordController,
                        obscureText: isObscureTextTwo,
                        decoration: InputDecoration(
                            labelText: 'Password Again',
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Color(0xff9098B1),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObscureTextTwo = !isObscureTextTwo;
                                });
                              },
                              icon: isObscureTextTwo
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                            ),
                            border: OutlineInputBorder())),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            print(nameController.text);
                            print(emailController.text);
                            print(passwordController.text);

                            if (FormKey.currentState!.validate()) {
                              if (passwordController.text ==
                                  secondPasswordController.text) {
                                signIn();
                              }
                            }
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Color(0xffFFFFFF)),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xff40BFFF))),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("have a account?",
                          style: TextStyle(
                              color: Color(0xff9098B1), fontSize: 16)),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return LoginPage();
                              },
                            ),
                          );
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                              color: Color(0xff40BFFF),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    try {
      final response =
          await Dio().post("https://api.escuelajs.co/api/v1/users/", data: {
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "avatar": "https://api.lorem.space/image/face?w=640&h=480"
      });
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) {
            return LoginPage();
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
