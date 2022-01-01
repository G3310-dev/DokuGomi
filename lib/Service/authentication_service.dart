import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, FirebaseAuthException, User;
import 'package:fluttertoast/fluttertoast.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  signIn({required String email, required String password}) async {
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      Fluttertoast.showToast(msg: e.message, toastLength: Toast.LENGTH_LONG);
    }
  }

  signUp({required String email, required String password}) async {
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      Fluttertoast.showToast(msg: e.message, toastLength: Toast.LENGTH_LONG);
    }
  }
}