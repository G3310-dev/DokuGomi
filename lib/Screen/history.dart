import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
    User user = FirebaseAuth.instance.currentUser;

    final CollectionReference collectionReference = FirebaseFirestore.instance.collection("Sell").doc(user.email).collection("Sell");

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(onTap:(){Navigator.pop(context);},child: Icon(Icons.arrow_back_ios)),
        toolbarHeight: 45,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/blr.png"),
                  fit: BoxFit.cover
              ),
            ),
          ),
          Container(
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: StreamBuilder(stream: collectionReference.orderBy("postDate", descending: true).snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if(snapshot.data!.size >= 1){
                            return ListView(
                              reverse: false,
                              children: snapshot.data!.docs.map((e) => Column(
                                children: [
                                  ListTile(
                                    title:
                                    Column(
                                      children: [
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text('Amount: ${e['amount']}',textAlign: TextAlign.left, style: TextStyle(color: Color(
                                                0xff46795e), fontSize: 18, fontWeight: FontWeight.bold),),
                                            Text('${e['unit']}',textAlign: TextAlign.left, style: TextStyle(color: Color(
                                                0xff46795e), fontSize: 18, fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      ],
                                    ),

                                    subtitle: Align(
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(height: 5,),
                                          SizedBox(height: 5,),
                                          Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Price: \$${e['amount']}',textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),)),
                                          SizedBox(height: 5,),
                                          Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Type: ${e['type']}",textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),)),
                                          SizedBox(height: 7,),
                                          Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Location: ${e['location']}",textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),)),
                                          SizedBox(height: 10,),
                                          Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text("\n${DateFormat('yyyy-MM-dd – kk:mm').format(e['postDate'].toDate())} UTC+7",textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),)),
                                          SizedBox(height: 5,),

                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(width: MediaQuery.of(context).size.width*0.9,child: Divider(color: Colors.white.withOpacity(0.5), thickness: 3,))
                                ],
                              )).toList(),
                            );
                          }
                          return Center(child:
                          Text('No History',textAlign: TextAlign.left, style: TextStyle(color: Color(
                              0xff346d4f), fontSize: 18, fontWeight: FontWeight.bold),),
                          );
                        },

                      )),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
