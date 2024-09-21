import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynant/global.dart';
import 'package:mynant/view/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  File? userImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
                child: Column(
                  children: [
                    const Text("Logo"),
                    const Text(
                      "Welcome to mynant",
                      style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: "Enter your email"),
                            style: const TextStyle(fontSize: 24),
                            controller: _email,
                            validator: (valueEmail) {
                              if (!valueEmail!.contains("@")) {
                                return "Enter a valid email";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: "Enter your password"),
                            style: const TextStyle(fontSize: 24),
                            controller: _password,
                            validator: (valueEmail) {
                              if (valueEmail!.length < 5) {
                                return "Password must be at least 5 characters long";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              userViewModel.login(
                                  _email.text.trim(), _password.text.trim());
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 0)),
                              onPressed: () {
                                Get.to(() => const SignupScreen());
                              },
                              child: const Text("New user? Signup"))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
