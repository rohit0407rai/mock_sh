import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class CustomNameTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;

  const CustomNameTextField({super.key, required this.controller, required this.hintText, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.textFieldColor,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16.sp,
            ),
            border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
          )
      ),
    );
  }
}
