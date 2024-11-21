import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sih_finals/common_widgets/custom_button.dart';
import 'package:sih_finals/common_widgets/custom_name_text_field.dart';
import 'package:sih_finals/common_widgets/custom_password_text_field.dart';
import 'package:sih_finals/screens/auth_screen/bloc/register/register_bloc.dart';
import 'package:sih_finals/screens/auth_screen/bloc/register/register_event.dart';
import 'package:sih_finals/screens/auth_screen/bloc/register/register_state.dart';
import 'package:sih_finals/utils/app_colors.dart';
import 'package:sih_finals/utils/app_text_styles.dart';

import '../controllers/password_get.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  final FocusNode _usernameFocusNode =
      FocusNode(); // FocusNode for username field
  final FocusNode _emailFocusNode = FocusNode(); // FocusNode for email field
  final FocusNode _passwordFocusNode =
      FocusNode(); // FocusNode for password field
  final FocusNode _confirmPasswordFocusNode =
      FocusNode(); // FocusNode for confirm password field

  // Instantiate PasswordController
  final PasswordController _passwordController = Get.put(PasswordController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterLoading) {
              showDialog(
                context: context,
                builder: (context) =>
                    const Center(child: CircularProgressIndicator()),
              );
            } else if (state is RegisterSuccess) {
              Navigator.pop(context); // Close the dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Registration Successful!")),
              );
            } else if (state is RegisterFailure) {
              Navigator.pop(context); // Close the dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Arrow-back icon
                Padding(
                  padding: EdgeInsets.only(top: 50.h, left: 20.w),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: AppColors.primaryBoundaryColor),
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),

                // Spacing between arrow-back icon and image
                SizedBox(height: 20.h),

                // Image, centered horizontally
                Center(
                  child: Image.asset(
                    "assets/images/regestration.png",
                    height: 80.h,
                    width: 80.w,
                  ),
                ),
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: InterText.text("Register", FontWeight.w600, 30.sp),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: InterText.text(
                      "Enter Your Personal Information", FontWeight.w400, 16.sp,
                      color: Colors.grey),
                ),
                SizedBox(height: 20.h),

                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child:
                            InterText.text("Username", FontWeight.w500, 16.sp),
                      ),
                      SizedBox(height: 10.h),
                      CustomNameTextField(
                        controller: _username,
                        hintText: "Enter your name",
                        focusNode: _usernameFocusNode,
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: InterText.text("Email", FontWeight.w500, 16.sp),
                      ),
                      SizedBox(height: 10.h),
                      CustomNameTextField(
                        controller: _email,
                        hintText: "Enter your email",
                        focusNode: _emailFocusNode,
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child:
                            InterText.text("Password", FontWeight.w500, 16.sp),
                      ),
                      SizedBox(height: 10.h),
                      Obx(() {
                        return CustomPasswordTextField(
                          controller: _password,
                          hintText: "Enter password",
                          focusNode: _passwordFocusNode,
                          isObscure: _passwordController.isObscure.value,
                          toggleObscure: _passwordController.toggleObscure,
                        );
                      }),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: InterText.text(
                            "Confirm Password", FontWeight.w500, 16.sp),
                      ),
                      SizedBox(height: 10.h),
                      Obx(() {
                        return CustomPasswordTextField(
                          controller: _confirmPassword,
                          hintText: "Enter Confirm password",
                          focusNode: _confirmPasswordFocusNode,
                          isObscure: _passwordController.isConfirmObscure.value,
                          toggleObscure:
                              _passwordController.toggleConfirmObscure,
                        );
                      }),
                      SizedBox(height: 40.h),
                      BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                          return GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  if (_password.text == _confirmPassword.text) {
                                    context.read<RegisterBloc>().add(
                                        RegistrationEvent(
                                            username: _username.text,
                                            email: _email.text,
                                            password: _password.text));
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                        Text("Passwords do not match!"),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: const CustomButton(text: "Register"));
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
