import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokugomi/Screen/Sell/lube.dart';
import 'package:dokugomi/Screen/Sell/oil.dart';
import 'package:dokugomi/Screen/Sell/paper.dart';
import 'package:dokugomi/Screen/Sell/plastic.dart';
import 'package:dokugomi/Screen/Sell/wood.dart';
import 'package:dokugomi/Screen/about.dart';
import 'package:dokugomi/Screen/account.dart';
import 'package:dokugomi/Screen/draw.dart';
import 'package:dokugomi/Screen/history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Sell/cardboard.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  int balance = 120;
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
  }
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;

    final CollectionReference collectionReference = FirebaseFirestore.instance.collection('Balance').doc('${user.email}').collection('Balance');

    return Scaffold(
      key: _globalKey,

      drawer: Container(
        width: MediaQuery.of(context).size.width*0.6,
        child: Drawer(
          child: SafeArea(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [

                ListTile(
                  leading: Image.asset("images/acc.png", width: MediaQuery.of(context).size.width*0.1,),
                  title: const Text('Account',style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Account()),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset("images/market.png", width: MediaQuery.of(context).size.width*0.1,),

                  title: const Text('Sell History',style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => History()),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset("images/info.png", width: MediaQuery.of(context).size.width*0.1,),

                  title: const Text('About',style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => About()),
                    );
                  },
                ),
              ],

            ),
          ),
        ),
      ),

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
          AnimatedOpacity(
            opacity: _looks ? 1.0:0.0,
            duration: const Duration(milliseconds: 2000),
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                          onPressed: (){
                            _globalKey.currentState!.openDrawer();
                          },
                          icon: Image.asset("images/hamburger.png")
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width * 0.8,
                        alignment: Alignment.centerLeft,
                        child: Text("Welcome",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "Dokupay",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff346d4f)
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width*0.5,
                                height: MediaQuery.of(context).size.height*0.04,
                                child: Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: StreamBuilder(stream: collectionReference.snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if(snapshot.data!.size == 1){
                                            return Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: ListView(
                                                    children: snapshot.data!.docs.map((e) => Row(
                                                        children: [
                                                          Text(
                                                            NumberFormat.compactCurrency(locale: "en", symbol: "\$ ", decimalDigits: 0).format(int.parse("${e['amount']}")),
                                                            textAlign: TextAlign.left,
                                                            style: TextStyle(
                                                                fontSize: 25,
                                                                color: Color(0xff878787),
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ]
                                                    )).toList()),
                                              ),
                                            );
                                          }
                                          return Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: ListView(
                                                      children: [
                                                        Text("\$0",
                                                          textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                              fontSize: 25,
                                                              color: Color(0xff878787),
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                      ]
                                                  )));
                                        }
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                child: IconButton(
                                    onPressed: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => Draw()),
                                      );
                                    },
                                    icon: Image.asset("images/tf.png")
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width * 0.8,
                        alignment: Alignment.centerLeft,
                        child: Text("Recycle Stuff :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => OIL()),
                                    );
                                  },
                                  child: Container(
                                      child: GestureDetector(
                                        child: Container(
                                            width: MediaQuery.of(context).size.width * 0.130,
                                            child: Image.asset("images/oil.png")
                                        ),
                                      )
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => LUBE()),
                                    );
                                  },
                                  child: Container(
                                      child: GestureDetector(
                                        child: Container(
                                            width: MediaQuery.of(context).size.width * 0.130,
                                            child: Image.asset("images/oli.png")
                                        ),
                                      )
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Plastic()),
                                    );
                                  },
                                  child: Container(
                                      child: GestureDetector(
                                        child: Container(
                                            width: MediaQuery.of(context).size.width * 0.130,
                                            child: Image.asset("images/bottle.png")
                                        ),
                                      )
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 35),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => Paper()),
                                          );
                                        },
                                        child: Container(
                                            width: MediaQuery.of(context).size.width * 0.130,
                                            child: Image.asset("images/paper.png")
                                        ),
                                      )
                                  ),
                                  Container(
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => Box()),
                                          );
                                        },
                                        child: Container(
                                            width: MediaQuery.of(context).size.width * 0.130,
                                            child: Image.asset("images/box.png")
                                        ),
                                      )
                                  ),
                                  Container(
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => Wood()),
                                          );
                                        },
                                        child: Container(
                                            width: MediaQuery.of(context).size.width * 0.130,
                                            child: Image.asset("images/wood.png")
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
