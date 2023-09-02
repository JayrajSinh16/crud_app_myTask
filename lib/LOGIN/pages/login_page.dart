import 'package:crud_app/LOGIN/components/my_textfield.dart';
import 'package:crud_app/LOGIN/components/square_title.dart';
import 'package:crud_app/LOGIN/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();


}

class _LoginPageState extends State<LoginPage> {
  //text editing controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();


  //sign user in method
  void signUserIn()async{

    //show loading circle
    showDialog(context: context, builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
    );

    
    // try sign in
    try {
       await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text
    );
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      //show erroe message
      showErrorMessage(e.code);
    }
  }

  //error message popup
  void showErrorMessage(String message){
    showDialog(context: context, builder: (context) {
      return  AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: const Color.fromARGB(255, 15, 20, 31),
        title: Center(
          child:  Text(
            message,
            style: const  TextStyle(
              color: Colors.white
            ),
            )
          ),
      );
    },
    );
  } 

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                //logo
                Image.asset(
                  'assets/logo_3.png',
                  scale: 1.2,
                ),
                const SizedBox(height: 18,),
                
                //Welcome line
                const Text(
                  "Welcome back you've been missed!!",
                  style: TextStyle(
                    color: Color.fromARGB(255, 139, 139, 139),
                    fontSize: 16,
                  ),
                ),
          
                const SizedBox(height: 25,),
          
                //email field
                MyTextField(
                  hintText: ' E-mail',
                  obscureText: false,
                  controller: emailController
                ),
          
                const SizedBox(height: 10,),
          
                //password field
                MyTextField(
                  hintText: ' Password',
                  obscureText: true,
                  controller: passwordController
                ),
          
                const SizedBox(height: 10),
          
                // forgot password?
                const Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Color.fromARGB(255, 139, 139, 139)),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 25),
          
                 // sign in button
                MyButton(
                  onTap: signUserIn,
                  title: "Sign In",
                ),
          
                const SizedBox(height: 50),
          
                //or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      const Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Color.fromARGB(255, 139, 139, 139)),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 15),
          
                 // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.baseline,                  
                  children: [
                    // google button
                    SquareTile(
                      imagePath: 'assets/google.png',
                      onTap: () => AuthService().signInWithGoogle(),
                      height: 50,
                      width: 50,
                    ),
                   const SizedBox(width: 8,),
                    // apple button
                    SquareTile(
                      imagePath: 'assets/apple_3.png',
                      onTap: () {} ,
                      height: 50,
                      width: 50,
                    ),
                  ],
                ),
          
                const SizedBox(height: 25),
                
                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     const Text(
                      'Not a member?',
                      style: TextStyle(color: Color.fromARGB(255, 189, 185, 185)),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 187, 71),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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