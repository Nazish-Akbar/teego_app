import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUser extends ChangeNotifier {
  String? appUserId;
  String? fullName;
  bool? isProfileCompleted;
  String? password;
  String? profileImage;
  String? confirmPassword;
  String? userEmail;
  String? phoneNumber;
  bool? isFirstLogin = false;
  DateTime? createdAt;

  AppUser({
    this.appUserId,
    this.profileImage,
    this.isProfileCompleted,
    this.password,
    this.userEmail,
    this.confirmPassword,
    this.phoneNumber,
    this.isFirstLogin,
    this.createdAt,
    this.fullName,
  });

  AppUser.fromJson(json, id) {
    this.appUserId = id;
    this.profileImage = json['profileImage'];
    this.isProfileCompleted = json['isProfileCompleted'];

    this.userEmail = json['userEmail'];
    this.phoneNumber = json['phoneNumber'] ?? '';
    this.isFirstLogin = json['isFirstLogin'];
    this.createdAt = json['createdAt'].toDate() ?? null;
    this.fullName = json['fullName'] ?? '';
  }
  toJson() {
    return {
      'fullName': this.fullName,
      'appUserId': this.appUserId,
      'isProfileCompleted': this.isProfileCompleted,
      'profileImage': this.profileImage,
      'userEmail': this.userEmail,
      'phoneNumber': this.phoneNumber,
      'isFirstLogin': this.isFirstLogin,
      'createdAt': this.createdAt,
    };
  }
}
