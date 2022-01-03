import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Forms1 extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final String name;
  User user = FirebaseAuth.instance.currentUser;

  Forms1(this.name, {Key? key}) : super(key: key);
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
                    child: Text(
                      "Sell $name",
                      style: const TextStyle(
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
                          labelText: "Amount / Liter",
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
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(
                        color: const Color(0x684a8565),
                        borderRadius: BorderRadius.circular(100)
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: passwordController,
                        decoration: const InputDecoration(
                          floatingLabelBehavior:FloatingLabelBehavior.never,
                          labelText: "Country/Location",
                          labelStyle: TextStyle(
                              fontSize: 15,
                              color: Color(0x6bffffff)
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0x004a8565)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0x004a8565)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0x004a8565)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      String email = emailController.text.trim();
                      final String password = passwordController.text.trim();
                      var unit = " Liter";

                      if(email.isEmpty){
                        Fluttertoast.showToast(msg: "Amount is empty", toastLength: Toast.LENGTH_LONG);
                      }else if(password.isEmpty){
                        Fluttertoast.showToast(msg: "Location is empty", toastLength: Toast.LENGTH_LONG);
                      }else{
                        if(email.contains(",") || email.contains(".")){
                          Fluttertoast.showToast(msg: "Please remove any punctuation on amount field", toastLength: Toast.LENGTH_LONG);
                        }else {
                          int value = int.parse(email);
                          Map <String,dynamic> data= {'postDate':  Timestamp.now(),'amount': emailController.text,'location': passwordController.text, 'name': user.email, 'type' : name, 'unit' : unit,};
                          FirebaseFirestore.instance.collection("Sell").doc(user.email).collection("Sell").add(data);
                          final DocumentReference docRef = Firestore.instance.collection("Balance").doc("${user.email}").collection("Balance").doc("${user.email}");
                          final TransactionHandler transactionHandler = (Transaction tran) => tran.get(docRef).then((DocumentSnapshot snap) {
                            if (snap.exists) {
                              tran.update(docRef, <String, dynamic>{'amount': snap.data()['amount'] + value});
                            }else{
                              docRef.setData({"amount": FieldValue.increment(value)});
                            }
                          });
                          Firestore.instance.runTransaction(transactionHandler);
                          final DocumentReference docRef2 = Firestore.instance.collection("Stock").doc(name);
                          final TransactionHandler transactionHandler2 = (Transaction tran) => tran.get(docRef2).then((DocumentSnapshot snap) {
                            if (snap.exists) {
                              tran.update(docRef2, <String, dynamic>{'amount': snap.data()['amount'] + value});
                            }else{
                              docRef2.setData({"amount": FieldValue.increment(value)});
                            }
                          });
                          Firestore.instance.runTransaction(transactionHandler2);
                          emailController.clear();
                          passwordController.clear();
                          Navigator.pop(context);
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "Congrats",
                                    style: TextStyle(
                                        fontSize: 20
                                    ),
                                  ),
                                  content: Text('You just earned \$$email',
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


                        }
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: const Color(0xff346d4f),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child:  const Text(
                        'Sell',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
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
