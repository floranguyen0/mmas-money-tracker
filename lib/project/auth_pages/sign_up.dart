// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../classes/textinput_decoration.dart';
// import 'loading_page.dart';
//
// class SignUp extends StatefulWidget {
//   @override
//   _SignUpState createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   final AuthService _auth = AuthService();
//   final _formKey = GlobalKey<FormState>();
//   String error = '';
//   bool loading = false;
//
//   // text field state
//   String email = '';
//   String password = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return loading
//         ? Loading()
//         : Scaffold(
//             backgroundColor: Colors.brown[100],
//             appBar: AppBar(
//               backgroundColor: Colors.brown[400],
//               elevation: 0.0,
//               title: Text('Sign up to Brew Crew'),
//               actions: <Widget>[
//                 FlatButton.icon(
//                   icon: Icon(Icons.person),
//                   label: Text('Sign In'),
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//             body: Container(
//               padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: <Widget>[
//                     SizedBox(height: 20.0),
//                     TextFormField(
//                       decoration:
//                           textInputDecoration.copyWith(hintText: 'email'),
//                       validator: (val) => val.isEmpty ? 'Enter an email' : null,
//                       onChanged: (val) {
//                         setState(() => email = val);
//                       },
//                     ),
//                     SizedBox(height: 20.0),
//                     TextFormField(
//                       decoration:
//                           textInputDecoration.copyWith(hintText: 'password'),
//                       obscureText: true,
//                       validator: (val) => val.length < 6
//                           ? 'Enter a password 6+ chars long'
//                           : null,
//                       onChanged: (val) {
//                         setState(() => password = val);
//                       },
//                     ),
//                     SizedBox(height: 20.0),
//                     RaisedButton(
//                         color: Colors.pink[400],
//                         child: Text(
//                           'Register',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         onPressed: () async {
//                           if (_formKey.currentState.validate()) {
//                             setState(() => loading = true);
//                             dynamic result = await _auth
//                                 .registerWithEmailAndPassword(email, password);
//
//                             if (result == null) {
//                               setState(() {
//                                 loading = false;
//                                 error = 'Please supply a valid email';
//                               });
//                             } else {
//                               Navigator.pop(context);
//                             }
//                           }
//                         }),
//                     SizedBox(height: 12.0),
//                     Text(
//                       error,
//                       style: TextStyle(color: Colors.red, fontSize: 14.0),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//   }
// }
