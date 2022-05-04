// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class DatabaseService {
//   static final usersCollection = FirebaseFirestore.instance.collection("users");
//   static final firebaseUser = FirebaseAuth.instance.currentUser;
//
//   static final Future<Map<String, dynamic>> userData = FirebaseFirestore
//       .instance
//       .collection("users")
//       .doc(FirebaseAuth.instance.currentUser.uid)
//       .get()
//       .then((data) => data.data());
//
//   Future<void> setUserData(
//     String type,
//     double amount,
//     String category,
//     String description,
//     String actualDateTime,
//     String dateSelected,
//     String timeSelected, {
//     bool premiumAccount,
//     String name = 'null',
//   }) async {
//     print('save');
//     return await usersCollection.doc(firebaseUser.uid).set({
//       "name": name,
//       "premiumAccount": premiumAccount,
//       "transactionInfo": FieldValue.arrayUnion([
//         { "type": type,
//           "amount": amount,
//           "category": category,
//           "description": description,
//           "dateSelected": dateSelected,
//           "timeSelected": timeSelected,
//           "actualDateTime": actualDateTime
//         }
//       ])
//     }, SetOptions(merge: true));
//   }
//
//   Future<void> updateUserData(String name, String type, int amount,
//       String category, String description, String date, String time) async {
//     return await usersCollection.doc(firebaseUser.uid).update({
//       "type": type,
//       "name": name,
//       "amount": amount,
//       "category": category,
//       "description": description,
//       "date": date,
//       "time": time
//     });
//   }
//
//   Future<void> deleteUserData() async {
//     return await usersCollection.doc(firebaseUser.uid).delete();
//   }
// }
