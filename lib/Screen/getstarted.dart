import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dokugomi/Screen/sign_in_page.dart';
import 'package:dokugomi/Screen/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  bool _looks = false;
  late Timer _timer;

  void initState() {
    super.initState();
    _timer = Timer(
      Duration(milliseconds: 300),
          () => {
        setState(() {
          _looks = true;
        }),
      },
    );
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
                AnimatedOpacity(
                  opacity: _looks ? 1.0:0.0,
                  duration: const Duration(milliseconds: 2000),
                  child: Container(
                    child: Text(
                      "DokuGomi",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width*0.06
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                AnimatedOpacity(
                  opacity: _looks ? 1.0:0.0,
                  duration: const Duration(milliseconds: 3500),
                  child: Text(
                    "Turn Your Trash Into Money",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width*0.04
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: _looks ? 1.0:0.0,
                  duration: const Duration(milliseconds: 4500),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 70),
                      alignment: Alignment.center,
                      width: 160,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Color(0xff346D4F),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child:  Text(
                        'Get Started',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
