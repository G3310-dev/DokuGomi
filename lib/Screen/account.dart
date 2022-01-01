import 'package:dokugomi/Service/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Account extends StatelessWidget {
  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/blr.png"),
                fit: BoxFit.cover
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/usr.png',
                  width: 95,
                  height: 97,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 15),
                  child: SelectableText('\nEmail: ${user.email}\n ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xff61CF93)
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: SelectableText('UID: ${user.uid}\n ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xff61CF93)
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                    context.read<AuthenticationService>().signOut();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 30),
                    width: 173,
                    height: 32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xff346D4F)
                    ),
                    child: Text('Log Out',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }
}