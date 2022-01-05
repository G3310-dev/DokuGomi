import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dokugomi/Screen/sign_in_page.dart';
import 'package:dokugomi/Service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController passwordController2 = TextEditingController();

  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (timer) {
      connect();
    });    connect();
  }

  Future<void> connect()async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print("I am connected to a mobile network.");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("I am connected to a wifi network.");
    }else{
      print("No Internet");    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/bg.jpg"),
                    fit: BoxFit.cover
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(
                        color: Color(0x684a8565),
                        borderRadius: BorderRadius.circular(100)
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: emailController,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: "Email",
                          labelStyle: new TextStyle(
                              fontSize: 15,
                              color: Color(0x6bffffff)
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0x4a8565)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0x4a8565)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0x4a8565)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                        color: Color(0x684a8565),
                        borderRadius: BorderRadius.circular(100)
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      child: TextField(
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        controller: passwordController,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: "Password",
                          labelStyle: new TextStyle(
                              fontSize: 15,
                              color: Color(0x6bffffff)
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0x4a8565)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0x4a8565)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0x4a8565)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                        color: Color(0x684a8565),
                        borderRadius: BorderRadius.circular(100)
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      child: TextField(
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        controller: passwordController2,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: "Confirm password",
                          labelStyle: new TextStyle(
                              fontSize: 15,
                              color: Color(0x6bffffff)
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0x4a8565)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0x4a8565)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0x4a8565)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      final String email = emailController.text.trim();
                      final String password = passwordController.text.trim();
                      final String password2 = passwordController2.text.trim();

                      if(email.isEmpty){
                        Fluttertoast.showToast(msg: "Email is empty", toastLength: Toast.LENGTH_LONG);
                      }else if(password.isEmpty){
                        Fluttertoast.showToast(msg: "Password is empty", toastLength: Toast.LENGTH_LONG);
                      }else{
                        if(password == password2){
                          context.read<AuthenticationService>().signUp(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                          Navigator.pop(context);
                        }else{
                          Fluttertoast.showToast(msg: "Confirm password don't match", toastLength: Toast.LENGTH_LONG);
                        }
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Color(0xff346d4f),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child:  Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Text('Already have account ?',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        )
    );
  }
}
