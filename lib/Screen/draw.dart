import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Draw extends StatefulWidget {
  @override
  State<Draw> createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  User user = FirebaseAuth.instance.currentUser;
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
      Fluttertoast.showToast(msg: "Not Connected to internet" );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(onTap:(){Navigator.pop(context);},child: Icon(Icons.arrow_back_ios)),
          toolbarHeight: 45,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
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
                    child: const Text(
                      "Withdraw Money",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(
                        color: const Color(0x684a8565),
                        borderRadius: BorderRadius.circular(100)
                    ),
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: emailController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                        ],
                        decoration: const InputDecoration(
                          floatingLabelBehavior:FloatingLabelBehavior.never,
                          labelText: "Amount/\$",
                          labelStyle: TextStyle(
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

                      if(email.isEmpty){
                        Fluttertoast.showToast(msg: "Amount is empty", toastLength: Toast.LENGTH_LONG);
                      }else{
                        if(email.contains(",") || email.contains(".")){
                          Fluttertoast.showToast(msg: "Please remove any punctuation on amount field", toastLength: Toast.LENGTH_LONG);
                        }else {
                          var email = int.parse(emailController.text);
                          var value = email*-1;
                          final DocumentReference docRef = Firestore.instance.collection("Balance").doc("${user.email}").collection("Balance").doc("${user.email}");
                          final TransactionHandler transactionHandler = (Transaction tran)=> tran.get(docRef).then((DocumentSnapshot snap) {
                            if (snap.data()['amount'] >= email) {
                              tran.update(docRef, <String, dynamic>{'amount': snap.data()['amount'] + value});
                              emailController.clear();
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        "[Done]",
                                        style: TextStyle(
                                            fontSize: 20
                                        ),
                                      ),
                                      content: Text('The money has been withdrawn',
                                        textAlign: TextAlign.left,
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, 'OK'),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  });
                            }else{
                              Fluttertoast.showToast(msg: "Your balance is not enough", toastLength: Toast.LENGTH_LONG);
                            }
                          });
                          Firestore.instance.runTransaction(transactionHandler);

                        }
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 30),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: const Color(0xff346d4f),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child:  const Text(
                        'Withdraw',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      child: GestureDetector(
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "!YOU REAL BANK ACCOUNT WON'T BE AFFECTED!",
                                    style: TextStyle(
                                        fontSize: 20
                                    ),
                                  ),
                                  content: Text('This is just a prototype,Only balance in app will be reduced, No money will be taken from your real bank account',
                                    textAlign: TextAlign.left,
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Text("\nAbout withdrawing",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

          ],
        )
    );
  }
}
