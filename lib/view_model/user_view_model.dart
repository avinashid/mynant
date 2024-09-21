import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynant/model/app_constants.dart';
import 'package:mynant/view/account_screen.dart';

class UserViewModel {
  signup(email, password, firstname, lastname, city, country, bio,
      userImage) async {
    Get.snackbar("Please wait", "Account creation in progress");

    try {
      var user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (user.user != null) {
        String currentUserId = user.user!.uid;
        AppConstants.currentUser.id = currentUserId;
        AppConstants.currentUser.firstname = firstname;
        AppConstants.currentUser.lastname = lastname;
        AppConstants.currentUser.city = city;
        AppConstants.currentUser.country = country;
        AppConstants.currentUser.bio = bio;
        AppConstants.currentUser.email = email;
        AppConstants.currentUser.password = password;

        await saveUserToFirestore(
          bio,
          city,
          country,
          email,
          firstname,
          lastname,
          currentUserId,
        ).whenComplete(() async {
          await saveAndUploadImageToFirestore(userImage, currentUserId);
        });

        Get.snackbar("Success", "Account created successfully");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> saveUserToFirestore(
      bio, city, country, email, firstname, lastname, id) async {
    Map<String, dynamic> dataMap = {
      "bio": bio,
      "city": city,
      "country": country,
      "email": email,
      "firstname": firstname,
      "lastname": lastname,
      "isHost": false,
      "myPostingIDs": [],
      "savedPostingIDs": [],
      "earnings": 0,
    };
    await FirebaseFirestore.instance.collection("users").doc(id).set(dataMap);
  }

  saveAndUploadImageToFirestore(File userImage, id) async {
    Reference referenceStorage =
        FirebaseStorage.instance.ref().child("userImages").child(id + ".png");

    await referenceStorage.putFile(userImage).whenComplete(() {});

    AppConstants.currentUser.displayImage =
        MemoryImage(userImage.readAsBytesSync());
  }

  login(email, password) async {
    try {
      Get.snackbar("Please wait", "Login in progress");
      var user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      AppConstants.currentUser.id = user.user!.uid;

      await getUserInfoFromFirestore(user.user!.uid);
      await getImageFromStorage(user.user!.uid);
      Get.to(() => const AccountScreen());
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  getUserInfoFromFirestore(userId) async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();
    AppConstants.currentUser.snapshot = documentSnapshot;
    AppConstants.currentUser.firstname = documentSnapshot['firstname'] ?? "";
    AppConstants.currentUser.lastname = documentSnapshot['lastname'] ?? "";
    AppConstants.currentUser.email = documentSnapshot['email'] ?? "";
    AppConstants.currentUser.city = documentSnapshot['city'] ?? "";
    AppConstants.currentUser.country = documentSnapshot['country'] ?? "";
    AppConstants.currentUser.bio = documentSnapshot['bio'] ?? "";
    AppConstants.currentUser.isHost = documentSnapshot['isHost'] ?? false;
  }

  getImageFromStorage(userId) async {
    if (AppConstants.currentUser.displayImage != null) {
      return AppConstants.currentUser.displayImage;
    }
    final imageDataInBytes = await FirebaseStorage.instance
        .ref()
        .child("userImages")
        .child(userId + ".png")
        .getData(1024 * 1024);
    AppConstants.currentUser.displayImage = MemoryImage(imageDataInBytes!);
    return AppConstants.currentUser.displayImage;
  }
}
