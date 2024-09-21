import 'package:flutter/material.dart';
import 'package:mynant/model/user_model.dart';

class ContactModel {
  String? id;
  String? firstname;
  String? lastname;
  String? fullname;
  MemoryImage? displayImage;

  ContactModel({
    this.id = "",
    this.firstname = "",
    this.lastname = "",
    this.fullname = "",
    this.displayImage,
  });

  String getFullNameOfUser() {
    return fullname = "$firstname $lastname";
  }

  UserModel createUserFromContract(){
    return UserModel(
      id: id!,
      firstname: firstname,
      lastname: lastname,
      fullname: fullname,
      displayImage: displayImage
    );
  }
}
