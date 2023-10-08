// ignore_for_file: prefer_const_constructors

import 'package:chatmessengerapp/components/my_button.dart';
import 'package:chatmessengerapp/components/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign in user
  void signIn() async{
    //get the auth user
    final authService = Provider.of<AuthService>(context,listen: false);
    try {
      await authService.signInWithEmailandPassword(
        emailController.text, passwordController.text);

    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(
          e.toString()
        ))
      );

    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
      child: SingleChildScrollView(
        child: Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50,),
                  //logo
                  Icon(
                    Icons.message,
                    size: 100,
                    color: Colors.grey[700],
                  ),
                  SizedBox(height: 50,),
                  //welcome back message
                  Text(
                    "Welcome Back We missed you!",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 25,),
                  //email
                  MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false),
                  SizedBox(height: 10),
                  //password
                   MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true),
                  SizedBox(height: 25),
                  //signin button
                  MyButton(onTap: signIn, text: "Sign In"),
              
                  SizedBox(height: 50),
                  //register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text('Not a member?'),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text('Register Now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                  ],)
                
              
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
