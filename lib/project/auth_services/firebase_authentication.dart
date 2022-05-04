import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_assistant_2608/project/classes/custom_toast.dart';


class FirebaseAuthentication {
  static Future<FirebaseApp> initializeFireBase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static Future<User?> googleSignIn({required BuildContext context}) async{
    User? user;
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if(googleSignInAccount != null){
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      try {
        final UserCredential userCredential = await auth.signInWithCredential(credential);
        user = userCredential.user;
      } on FirebaseException catch (e) {
        if (e.code == 'account-exists-with-different-credentia') {
          customToast(context,'The account already exists with a different credential.');
        } else
        if (e.code == 'invalid-credential') {
          customToast(context,'Error occurred while accessing credentials. Try again.');
        }
      }catch(e){
        customToast(context,'Error occurred using Google Sign-In. Try again.');
      }
    }
    return user;
  }

  static Future<void> signOut({required BuildContext context})async{
final  GoogleSignIn googleSignIn =  GoogleSignIn();
try{
  await googleSignIn.signOut();
} catch (e){
  customToast(context, 'Error signing out. Try again.');
}
  }
}
// final FirebaseAuth _auth = FirebaseAuth.instance;
//
// UserUid _userUid(User user) {
//   return user != null ? UserUid(uid: user.uid) : null;
// }
//
// // what is get?
// Stream<UserUid> get user {
//   return _auth.authStateChanges().map((User user) => _userUid(user));
//   // .map(_userUid);
// }
//
// // sign in anon
// Future signInAnon() async {
//   try {
//     UserCredential result = await _auth.signInAnonymously();
//     User user = result.user;
//     return _userUid(user);
//   } catch (e) {
//     print(e.toString());
//     return null;
//   }
// }
//
// // sign in with email and password
// Future signInWithEmailAndPassword(String email, String password) async {
//   try {
//     UserCredential result = await _auth.signInWithEmailAndPassword(
//         email: email, password: password);
//     User user = result.user;
//     return user;
//   } catch (error) {
//     print(error.toString());
//     return null;
//   }
// }
//
// // register with email and password
// Future registerWithEmailAndPassword(String email, String password) async {
//   try {
//     UserCredential result = await _auth.createUserWithEmailAndPassword(
//         email: email, password: password);
//     User user = result.user;
//     return _userUid(user);
//   } catch (error) {
//     print(error.toString());
//     return null;
//   }
// }
//
// // sign out
// Future signOut() async {
//   try {
//     return await _auth.signOut();
//   } catch (error) {
//     print(error.toString());
//     return null;
//   }
// }
// }

// class UserUid {
//   final String uid;
//
//   UserUid({this.uid});
// }
