import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled09/auth/authservice.dart';

import '../components/mybuttons.dart';
import '../components/mytextfield.dart';

class Registerpage extends StatefulWidget {
  final  void Function()? onTap;
  const Registerpage({super.key,required this.onTap});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  @override
  Widget build(BuildContext context) {
    //text controllers

  final emailController =TextEditingController();
  final passwordController =TextEditingController();
  final confirmpasswordController =TextEditingController();
  //sign up user
  void signUp()async{
    if(passwordController.text !=confirmpasswordController.text){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:Text("Passwords do not match"), ),
      );
      return;
    }
    //get auth service
    final authService = Provider.of<AuthService>(context,listen: false);
    try {
      await authService.signUpWithEmailandPassword(
          emailController.text,
          passwordController.text,
    );
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:Text(e.toString()),
        ),
        );
      }
    }



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
                Text("Create an account", style: TextStyle(fontSize: 16,color: Colors.white),),
                const SizedBox(height: 10,),
                MyTextField(controller: emailController,
                    obscureText: false,
                    hintText: 'Email',),
                MyTextField(controller: passwordController,
                    obscureText: true,
                    hintText: 'Password'),
                MyTextField(controller: confirmpasswordController,
                    obscureText: true,
                    hintText: 'Confirm Password'),
                const SizedBox(height: 25,),
                MyButton(onTap: signUp, text: "Sign Up"),
                const SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already a member?",style: TextStyle(color: Colors.white),),
                    const SizedBox(height: 4,),
                    GestureDetector(
                        onTap: widget.onTap,
                        child: const Text("Login now",
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),))
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

