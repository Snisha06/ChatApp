import 'package:flutter/material.dart';
import 'package:untitled09/page/loginpage.dart';
import 'package:untitled09/page/registerpage.dart';

import '../pages/loginpage.dart';
import '../pages/registerpage.dart';
class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginorRegisterState();
}

class _LoginorRegisterState extends State<LoginOrRegister> {
  //initially show the login screen
  bool showLoginPage = true;
  //toggle between 2 pages
  void togglePages(){
    setState(() {
      showLoginPage =!showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(onTap: togglePages);
    } else {
      return Registerpage(onTap: togglePages);
    }
  }
}