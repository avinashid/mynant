import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mynant/global.dart';
import 'package:mynant/view/login_screen.dart';
import 'package:path/path.dart' as path;

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
                            obscureText: true,
                            validator: (valueEmail) {
                              if (valueEmail!.length < 5) {
                                return "Password must be at least 5 characters long";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            minLines: 2,
                            maxLines: 3,
                            decoration: const InputDecoration(
                                labelText: "Bio", alignLabelWithHint: true),
                            style: const TextStyle(fontSize: 24),
                            controller: _bio,
                            validator: (valueEmail) {
                              if (valueEmail!.length < 5) {
                                return "Bio must be at least 5 characters long";
                              }
                              return null;
                            },
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 20),
                            alignment: Alignment.centerLeft,
                            child: userImage == null
                                ? MaterialButton(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 0),
                                    onPressed: () async {
                                      var imageFile = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery);
                                      if (imageFile != null) {
                                        userImage = File(imageFile.path);
                                        setState(() {
                                          userImage;
                                        });
                                      }
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(Icons.add_a_photo),
                                        SizedBox(width: 10),
                                        Text("Please select an image")
                                      ],
                                    ),
                                  )
                                : Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: const Color.fromARGB(
                                            255, 245, 222, 230),
                                        radius: 30,
                                        child: CircleAvatar(
                                          backgroundImage:
                                              FileImage(userImage!),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        path.basename(userImage!.path),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      const SizedBox(width: 10),
                                      IconButton(
                                        padding: const EdgeInsets.all(0),
                                        icon: const Icon(
                                          Icons.cancel,
                                        ),
                                        onPressed: () {
                                          userImage = null;
                                          setState(() {
                                            userImage;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                Get.snackbar("Field Missing",
                                    "Please fill out complete signup form.");
                                return;
                              } else if (userImage == null) {
                                Get.snackbar("Image Missing",
                                    "Please select your profile picture.");
                                return;
                              }
                              userViewModel.signup(
                                  _email.text.trim(),
                                  _password.text.trim(),
                                  _firstname.text.trim(),
                                  _lastname.text.trim(),
                                  _city.text.trim(),
                                  _country.text.trim(),
                                  _bio.text.trim(),
                                  userImage);
                            },
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
