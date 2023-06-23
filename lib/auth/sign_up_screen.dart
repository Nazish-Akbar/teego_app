// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, unused_import

import 'package:Hilite/auth/dispache_screen.dart';
import 'package:Hilite/auth/sign_in_screen.dart';
import 'package:Hilite/auth/sign_up_provider.dart';
import 'package:Hilite/widgets/custom_textfield.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../core/enums/view_state.dart';
import '../widgets/custom_button.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  String? name;
  String? password;
  String? email;
  TextEditingController? namecontroller;
  TextEditingController? emailcontroller;
  TextEditingController? passwordcontroller;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpProvider(),
      child: Consumer<SignUpProvider>(builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: ModalProgressHUD(
              inAsyncCall: model.state == ViewState.busy,
              child: Padding(
                padding: EdgeInsets.all(34.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: model.formKey,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/ic_logo.png",
                          height: 225,
                          width: 250,
                        ),

                        Text(
                          'Enter Your Credentials to create account ',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xffB8B8B8),
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 30),
                        customTextField(
                          hinttext: 'Enter Email',
                          onChanged: (value) {
                            model.appUser.userEmail = value;
                          },
                          controller: emailcontroller,
                        ),
                        SizedBox(height: 20),
                        customTextField(
                          hinttext: 'Enter Password',
                          onChanged: (value) {
                            model.appUser.password = value;
                          },
                          controller: passwordcontroller,
                        ),
                        SizedBox(height: 20),
                        customTextField(
                          hinttext: 'Confirm Password',
                          onChanged: (value) {
                            model.appUser.confirmPassword = value;
                          },
                        ),
                        // SizedBox(height: 20.h),
                        // CustomTextField(
                        //   hintText: 'Confirm Password',
                        //   onchanged: (val) {
                        //     password = val;
                        //   },
                        //   controller: passwordcontroller,
                        //   textAlign: TextAlign.start,
                        // ),
                        SizedBox(height: 75),
                        // Spacer(),
                        CustomButton(
                          tap: () async {
                            model.signUpUser(model.appUser, context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DispacheScreen(
                                        preferences: model.preferences,
                                      )),
                            );
                          },
                          text: 'Create account',
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInScreen()));
                            // Navigator.pushReplacement(
                            //     context, CustomPageRoute(child: SignUpScreen()));
                          },
                          // onTap: () => Get.offAll(() => SignUpScreen()),
                          child: RichText(
                            text: TextSpan(
                                text: "Already have an account?  ",
                                style: TextStyle(color: Colors.grey),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "Sign In",
                                      style: TextStyle(color: Colors.blue))
                                ]),
                          ),
                        ),
                        SizedBox(height: 10),
                        RichText(
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'By continuing, you agree to our ',
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                            children: [
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue,
                                    fontSize: 14),
                                // Add Privacy Policy onTap handler here
                              ),
                              TextSpan(text: ' &\n '),
                              TextSpan(
                                text: 'Terms Of Use',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue,
                                  fontSize: 14,
                                ),
                                // Add Terms of Use onTap handler here
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
