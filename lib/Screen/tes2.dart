import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;

    final CollectionReference collectionReference = FirebaseFirestore.instance.collection("Sell").doc(user.email).collection("Sell");    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(onTap:(){Navigator.pop(context);},child: Icon(Icons.arrow_back_ios)),
        toolbarHeight: 45,
        backgroundColor: Color(0xff323232),
      ),
      backgroundColor: Color(0xff323232),
      body: Column(
        children: <Widget>[
          Expanded(
              child: StreamBuilder(stream: collectionReference.orderBy("postDate", descending: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.hasData){
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
                                    Text('${e['amount']}',textAlign: TextAlign.left, style: TextStyle(color: Color(
                                        0xff61CF93), fontSize: 18, fontWeight: FontWeight.bold),),
                                    Text('${e['unit']}',textAlign: TextAlign.left, style: TextStyle(color: Color(
                                        0xff61CF93), fontSize: 18, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ],
                            ),

                            subtitle: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 10,),
                                  SizedBox(height: 5,),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(e['type'],textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)),
                                  SizedBox(height: 10,),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(e['location'],textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)),
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
                  return Center(child: CircularProgressIndicator());
                },

              )),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}