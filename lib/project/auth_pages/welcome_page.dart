// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'sign_in.dart';
// import 'sign_up.dart';
//
// class WelcomePage extends StatefulWidget {
//   @override
//   _WelcomePageState createState() => _WelcomePageState();
// }
//
// class _WelcomePageState extends State<WelcomePage> {
//   @override
//   Widget build(BuildContext context) {
//     print('Welcome Page');
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(139, 205, 254, 1),
//       appBar: AppBar(
//         backgroundColor: Colors.orange,
//         title: Text(
//           'Welcome Page',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                   icon: Icon(
//                     Icons.login,
//                   ),
//                   onPressed: () => Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => SignIn())),
//                 ),
//                 Text(
//                   'Sign in',
//                   style: TextStyle(fontSize: 20),
//                 )
//               ],
//             ),
//             Row(
//               children: [
//                 IconButton(
//                   icon: Icon(
//                     Icons.app_registration,
//                   ),
//                   onPressed: () => Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => SignUp())),
//                 ),
//                 Text(
//                   'Sign up',
//                   style: TextStyle(fontSize: 20),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
