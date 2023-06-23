import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/enums/view_state.dart';
import '../core/locator.dart';
import '../core/models/app_user.dart';
import '../core/models/base_view_model.dart';
import '../core/services/auth_services.dart';
import '../core/services/custom_auth_result.dart';

class SignUpProvider extends BaseViewModal {
  // final authServices = AuthServices();
  final _authServices = locator<AuthServices>();
  SharedPreferences? preferences;
  CustomAuthResult customAuthResult = CustomAuthResult();
  AppUser appUser = AppUser();
  final formKey = GlobalKey<FormState>();
  bool isAgreeTermsAndConditions = false;
  bool isVisiblePassword = true;

  ///
  /// Visible Password
  ///
  visiblePassword() {
    print("Password state : $isVisiblePassword");
    isVisiblePassword = !isVisiblePassword;
    notifyListeners();
    print("Password final state : $isVisiblePassword");
  }

  termsAndConditions(value) {
    isAgreeTermsAndConditions = value;
    print("Terms and conditions $isAgreeTermsAndConditions");
    notifyListeners();
  }

  ///
  /// Sign Up user
  ///
  signUpUser(AppUser appUser, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      // sign up user
      if (true) {
        print("User Email: ${appUser.userEmail}");

        appUser.isFirstLogin = true;
        setState(ViewState.busy);

        appUser.createdAt = DateTime.now();

        // appUser.lastMessageAt = DateTime.now();
        customAuthResult = await _authServices.signUpUser(appUser, context);
        print("dataaaaaaaaaaaaaaaaaaaaa");
        setState(ViewState.idle);
        if (customAuthResult.user != null) {
          print("SignUpUserId=> ${_authServices.appUser.appUserId}");

          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => OnboardingScreen()));

          //  / Walkthrough screeens
        } else {
          // showSnackBar(context, customAuthResult.errorMessage!);
          // Get.defaultDialog(
          //   title: "Error Message",
          //   confirmTextColor: Colors.white,
          //   onConfirm: () {
          //     Navigator.pop(context);
          //   },
          //   content: Text(customAuthResult.errorMessage!),
          // );
        }
      } else {
        // showSnackBar(context, "You must agree to Terms and Conditions");
      }
      // Get.offAll(()=>WalkThroughScreen());
    }
  }
}
