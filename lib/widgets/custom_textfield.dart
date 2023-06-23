import 'package:flutter/material.dart';

class customTextField extends StatelessWidget {
  final hinttext;
  final prefixIcon;
  bool obscureText;
  final onChanged;
  final validator;
  final controller;
  final sufFixIcon;
  final textInputAction;
  final keyBoardType;
  final maxLine;

  customTextField(
      {this.hinttext,
      this.prefixIcon,
      this.onChanged,
      this.validator,
      this.controller,
      this.obscureText = false,
      this.sufFixIcon,
      this.keyBoardType,
      this.textInputAction,
      this.maxLine});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        textInputAction: textInputAction,
        keyboardType: keyBoardType,
        obscureText: obscureText,
        controller: controller,
        // maxLines: maxLine,
        // minLines: ,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          hintText: hinttext,
          hintStyle: TextStyle(color: Color(0xffBDBCBC)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffBDBCBC), width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffBDBCBC), width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          prefixIcon: prefixIcon,
          suffixIcon: sufFixIcon,
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffBDBCBC), width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
    );
  }
}
