import 'package:flutter/material.dart';

import '../core/enums/view_state.dart';
import '../core/locator.dart';
import '../core/models/app_user.dart';
import '../core/models/base_view_model.dart';
import '../core/services/auth_services.dart';
import '../core/services/custom_auth_result.dart';
import '../core/services/database_services.dart';

class LoginProvider extends BaseViewModal {
  final _authService = locator<AuthServices>();
  AppUser appUser = AppUser();
  final databaseServices = DatabaseServices();
  CustomAuthResult customAuthResult = CustomAuthResult();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool? isVisiblePassword = true;
  bool isRememberMe = false;

  // LoginProvider(){
  //   isRememberMe = false;
  //   isVisiblePassword = true;
  // }

  rememberMe(value) {
    isRememberMe = value;
    notifyListeners();
  }

  ///
  /// Visible Password
  ///
  visiblePassword() {
    print("Password state : $isVisiblePassword");
    isVisiblePassword = !isVisiblePassword!;
    notifyListeners();
    print("Password final state : $isVisiblePassword");
  }

  resetPassword() async {
    if (appUser.userEmail != null) {
      print('Reset User password Email=>${appUser.userEmail}');
      await _authService.resetUserPassword(appUser.userEmail!);
    }
  }

  ///
  /// Login user
  ///
  loginUser(AppUser appUser, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      print("App user email: ${appUser.userEmail}");
      print("App user Password: ${appUser.password}");
      setState(ViewState.busy);

      await databaseServices.updateUserProfile(appUser);
      print('custom auth result ${customAuthResult.user}');
      customAuthResult = await _authService.loginUser(appUser);
      print('custom aaaauth result ${customAuthResult.user}');
      setState(ViewState.idle);
      print('userr: ${customAuthResult.user}');
      if (customAuthResult.user != null) {
        print("App user Id: ${_authService.appUser.appUserId}");
        print("Is first Login=> ${_authService.appUser.isFirstLogin}");
        if (_authService.appUser.isFirstLogin == true) {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else if (_authService.appUser.isFirstLogin == false) {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => OnboardingScreen()));
        }
      } else {
        // showSnackBar(
        //   context,
        //   "${customAuthResult.errorMessage!}",
        //   duration: 5000,
        // );
        // Get.defaultDialog(
        //     title: "Error",
        //     content: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Text(
        //         "${customAuthResult.errorMessage!}",
        //       ),
        //     ),
        //     confirm: FlatButton(
        //       color: Color(0xFF568C48),
        //       onPressed: () {
        //         Get.back();
        //       },
        //       child: Text("OK", style: TextStyle(color: Colors.white)),
        //     ));
        ///////////
        // title: "Error Message",
        // confirmTextColor: Colors.white,
        // onConfirm: () {
        //   Navigator.pop(context);
        // },
        // content: Text(customAuthResult.errorMessage!),
        // );
      }
      // Get.offAll(()=>WalkThroughScreen());
      // login
      customAuthResult = CustomAuthResult();
    }
  }
}
