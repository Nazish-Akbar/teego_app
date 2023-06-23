// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:Hilite/auth/sign_up_screen.dart';
import 'package:Hilite/auth/signin_provider.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:provider/provider.dart';

import '../core/enums/view_state.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  String? email;

  String? password;
  TextEditingController? passwordcontroller;
  TextEditingController? emailcontroller;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: Consumer<LoginProvider>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                body: Form(
                  key: model.formKey,
                  child: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  height: 338,
                                  width: 428,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/ic_logo.png"))),
                                  margin: EdgeInsets.only(top: 5),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Text(
                                      'Welcome back \nto Brain 2',
                                      style: TextStyle(
                                          fontSize: 38,
                                          color: Colors.white,
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Enter Your Credentials to continue',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xffB8B8B8),
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(height: 30),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 34, right: 34),
                                  child: customTextField(
                                    hinttext: 'Enter Email',
                                    onChanged: (value) {
                                      model.appUser.userEmail = value;
                                    },
                                    controller: emailcontroller,
                                  ),
                                ),
                                SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 34, right: 34),
                                  child: customTextField(
                                    hinttext: 'Enter Password',
                                    onChanged: (value) {
                                      model.appUser.password = value;
                                    },
                                    controller: passwordcontroller,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 50),
                          Padding(
                            padding: const EdgeInsets.only(left: 34, right: 34),
                            child: CustomButton(
                              tap: () {
                                model.loginUser(model.appUser, context);
                              },
                              text: 'Sign in',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()));
                              // Navigator.pushReplacement(
                              //     context, CustomPageRoute(child: SignUpScreen()));
                            },
                            // onTap: () => Get.offAll(() => SignUpScreen()),
                            child: RichText(
                              text: TextSpan(
                                  text: "Don't have an account?  ",
                                  style: TextStyle(color: Colors.grey),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Sign Up",
                                      style: TextStyle(color: Colors.blue),
                                    )
                                  ]),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 41),
                            child: RichText(
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'By continuing, you agree to our ',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue,
                                        fontSize: 15),
                                    // Add Privacy Policy onTap handler here
                                  ),
                                  TextSpan(text: ' &\n '),
                                  TextSpan(
                                    text: 'Terms Of Use',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue,
                                      fontSize: 15,
                                    ),
                                    // Add Terms of Use onTap handler here
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
