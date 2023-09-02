import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({super.key, this.controller, required this.hintText, required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  cursorColor: const  Color.fromARGB(255, 139, 139, 139),
                  cursorHeight: 28,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 203, 196, 196),
                  ),
                  controller: controller,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    enabledBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: const Color.fromARGB(255, 53, 53, 53),
                    filled: true,
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 203, 196, 196),
                      ),
                  ),
                ),
              );
  }
}