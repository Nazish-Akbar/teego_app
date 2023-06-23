import 'package:Hilite/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/social_login.dart';
import '../models/app_user.dart';
import 'auth_exception_message.dart';
import 'custom_auth_result.dart';
import 'database_services.dart';

class AuthServices {
  final databaseServices = DatabaseServices();
  final customAuthResult = CustomAuthResult();
  //QuestionnairesModel questionnairesModel = QuestionnairesModel();
  final authInstant = FirebaseAuth.instance;
  bool? isLogin;
  User? user;
  AppUser appUser = AppUser();
  late SharedPreferences preferences;

  AuthServices() {
    init();
  }

  init() async {
    user = authInstant.currentUser;
    if (user != null) {
      isLogin = true;
      this.appUser = await databaseServices.getUser(user!.uid);
      // this.questionnairesModel =
      //     await databaseServices.getQuestionnaires(user!.uid);
      print('userId => ${this.appUser.appUserId}');
    } else {
      isLogin = false;
    }
  }

  Future<CustomAuthResult> signUpUser(AppUser appUser, context) async {
    try {
      final credential = await authInstant.createUserWithEmailAndPassword(
          email: appUser.userEmail!, password: appUser.password!);
      if (credential.user != null) {
        print('user registered');
        // SocialLogin.goHome(context, user!, preferences);

        this.appUser = appUser;
        this.appUser.appUserId = credential.user!.uid;
        // this.appUser.statusLenghthOfAdminMessages = 0;
        // this.appUser.statusLenghOfIndividualMsgs = 0;
        this.isLogin = true;
        print("SignUpUserId=> ${this.appUser.appUserId}");
        await databaseServices.registerUser(appUser);

        this.appUser = await databaseServices.getUser(credential.user!.uid);
        customAuthResult.user = credential.user;
      }
    } catch (e) {
      print('Exception@signUpUser $e');
      customAuthResult.errorMessage =
          AuthExceptionsMessages.generateExceptionMessage(e);
    }
    return customAuthResult;
  }

  ///
  /// Login user
  ///
  Future<CustomAuthResult> loginUser(AppUser appUser) async {
    try {
      final credentials = await authInstant.signInWithEmailAndPassword(
          email: appUser.userEmail!, password: appUser.password!);
      print("User logined successfully");
      if (credentials.user != null) {
        customAuthResult.user = credentials.user;
        this.appUser = appUser;
        this.appUser.appUserId = credentials.user!.uid;
        this.isLogin = true;

        ///
        /// Get user
        ///
        this.appUser = await databaseServices.getUser(credentials.user!.uid);
        //this.appUser.fcmToken = await FirebaseMessaging.instance.getToken();
        await databaseServices.updateUserProfile(this.appUser);
      }
    } catch (e) {
      print('Exception@LoginUser $e');
      customAuthResult.errorMessage =
          AuthExceptionsMessages.generateExceptionMessage(e);
    }
    return customAuthResult;
  }

  ///
  /// Reset user password
  ///
  Future<bool> resetUserPassword(String email) async {
    print('Reset User password Email=>$email');
    await authInstant.sendPasswordResetEmail(email: email);
    return true;
    print('Link sent to Email=>$email');
  }

  ///
  /// Logout user
  ///
  Future<void> logoutUser() async {
    await authInstant.signOut();
    this.isLogin = false;
    this.appUser = AppUser();
    this.user = null;
  }

  Future<void> deleteUser({final email, final password}) async {
    try {
      print('delete user called');

      User newUser = authInstant.currentUser!;

      print("email:" + email);
      print(password);

      AuthCredential credentials =
          EmailAuthProvider.credential(email: email, password: password);
      // EmailAuthProvider.getCredential(email: email, password: password);

      final result = await newUser.reauthenticateWithCredential(credentials);
      //await databaseServices.deleteUser(); // called from adatabase class
      await result.user!.delete();
    } catch (e) {
      print("hello catch occuring");
      print(e.toString());
      return null;
    }
  }
}
