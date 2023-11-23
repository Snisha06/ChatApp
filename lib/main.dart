import 'dart:js';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled09/authgate.dart';
import 'package:untitled09/page/homepage.dart';
import 'package:untitled09/page/loginpage.dart';
import 'package:untitled09/page/registerpage.dart';
import 'package:untitled09/services/auth/authservice.dart';
import 'package:untitled09/services/auth/loginorRegister.dart';
import 'package:untitled09/services/authgate.dart';
import 'package:provider/provider.dart';

import 'auth/authservice.dart';
//VZSqCzXZq4VLtZQ9fv3WwGwKH3h1
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
    appId:'com.example.msgapp',
    apiKey:'AIzaSyDx7P7D0MdYUdEnoDPkDINm2vKn-A1CAng',
    messagingSenderId: '432571035040' ,
    projectId: 'msgapp-ac8c2',
  ),);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(
          create: (context)=> AuthService(),
        ),
      ],
      child: MyApp(),

    ),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:AuthGate(),
    );
  }
}