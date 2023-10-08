// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:chatmessengerapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/my_button.dart';
import '../components/my_text_field.dart';
import '../services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //sign up user
  void signup() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Paswwords do not match')));
          return;
    }

    //get Auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    try{
      await authService.signUpWithEmailandPassword(emailController.text, passwordController.text);

    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      //logo
                      Icon(
                        Icons.message,
                        size: 100,
                        color: Colors.grey[700],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      //create account message
                      Text(
                        "Let's create an account for you!",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
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

                      SizedBox(height: 10),
                      //confirm password
                      MyTextField(
                          controller: confirmPasswordController,
                          hintText: 'Confirm Password',
                          obscureText: true),

                      SizedBox(height: 25),
                      //signin button
                      MyButton(onTap: signup, text: "Create Account"),

                      SizedBox(height: 50),
                      //register
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already a member?'),
                          SizedBox(width: 4),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              'Login Now',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
