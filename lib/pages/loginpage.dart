import 'package:flutter/material.dart';
import 'package:untitled09/components/mybuttons.dart';
import 'package:untitled09/components/mytxtfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled09/auth/authservice.dart';
import 'package:provider/provider.dart';

import '../components/mytextfield.dart';
class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController =TextEditingController();
  final passwordController =TextEditingController();
  void signIn()async{
    final authService = Provider.of<AuthService>(context,listen:false);
    try{
      await authService.signInWithEmailandPassword(
          emailController.text,
          passwordController.text);
    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString(),),),);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50,),
            Image.asset('assets/msg.png'),
                // Icon(Icons.message,size: 200,color: Colors.black26,),
                Text("Welcome back you've been missed",style: TextStyle(fontSize: 16,color: Colors.white),),
                const SizedBox(height: 10,),
                MyTextField(controller: emailController, obscureText: false, hintText: 'Email'),
                MyTextField(controller: passwordController, obscureText: true, hintText: 'Password'),
                const SizedBox(height: 25,),
                MyButton(onTap: signIn, text: "SignIn"),
                const SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const  Text('Not a member?',style: TextStyle(color: Colors.white),),
                    const SizedBox(height: 4,),
                    GestureDetector(
                        onTap:widget.onTap,
                        child:const Text("Register now",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}