import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;

    final CollectionReference collectionReference = FirebaseFirestore.instance.collection("Sell").doc(user.email).collection("Sell");

    return Scaffold(
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
            margin: EdgeInsets.only(top: 10),
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
