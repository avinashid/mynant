import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynant/view/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final TextEditingController _bio = TextEditingController();
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
                      "Create new account",
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
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: const Text(
                              "Please enter the following details",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: "First name"),
                            style: const TextStyle(fontSize: 24),
                            controller: _firstname,
                            validator: (valueEmail) {
                              if (valueEmail!.length < 3) {
                                return "Invalid firstname";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: "Last name"),
                            style: const TextStyle(fontSize: 24),
                            controller: _lastname,
                            validator: (valueEmail) {
                              if (valueEmail!.length < 3) {
                                return "Invalid lastname";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: "City"),
                            style: const TextStyle(fontSize: 24),
                            controller: _city,
                            validator: (valueEmail) {
                              if (valueEmail!.length < 3) {
                                return "Invalid city";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: "Country"),
                            style: const TextStyle(fontSize: 24),
                            controller: _country,
                            validator: (valueEmail) {
                              if (valueEmail!.length < 3) {
                                return "Invalid country";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: "Email"),
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
                            decoration:
                                const InputDecoration(labelText: "Password"),
                            style: const TextStyle(fontSize: 24),
                            controller: _password,
                            validator: (valueEmail) {
                              if (valueEmail!.length < 5) {
                                return "Password must be at least 5 characters long";
                              }
                              return null;
                            },
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 20),
                            alignment: Alignment.centerLeft,
                            child: userImage == null
                                ? const Row(
                                    children: [
                                      Icon(Icons.add_a_photo),
                                      SizedBox(width: 10),
                                      Text("Please select an image")
                                    ],
                                  )
                                : CircleAvatar(
                                    backgroundColor: Colors.pink,
                                    radius: 30,
                                    child: CircleAvatar(
                                      backgroundImage: FileImage(userImage!),
                                    ),
                                  ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            onPressed: () {},
                            child: const Text(
                              "Signup",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 0)),
                              onPressed: () {
                                Get.to(() => const LoginScreen());
                              },
                              child:
                                  const Text("Already have an account? Login"))
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
