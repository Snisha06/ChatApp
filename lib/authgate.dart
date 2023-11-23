import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled09/page/homepage.dart';
import 'package:untitled09/pages/homepage.dart';
import 'package:untitled09/services/auth/loginorRegister.dart';

import 'auth/loginorregister.dart';
class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          //user is logged in
          if (snapshot.hasData){
            return const HomePage();
          }
          //user is not logged in
          else
          {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
