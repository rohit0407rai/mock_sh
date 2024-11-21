import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sih_finals/common_widgets/custom_button.dart';
import 'package:sih_finals/common_widgets/custom_name_text_field.dart';
import 'package:sih_finals/common_widgets/custom_password_text_field.dart';
import 'package:sih_finals/screens/auth_screen/bloc/auth/auth_bloc.dart';
import 'package:sih_finals/screens/auth_screen/bloc/auth/auth_state.dart';
import 'package:sih_finals/utils/app_colors.dart';
import 'package:sih_finals/utils/app_text_styles.dart';

import '../bloc/auth/auth_event.dart';
import '../controllers/password_get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final PasswordController _passwordController = Get.put(PasswordController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationLoading) {
              showDialog(
                context: context,
                builder: (context) =>
                    const Center(child: CircularProgressIndicator()),
              );
            } else if (state is AuthenticationSuccess) {
              Navigator.pop(context); // Close the dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Login Successful!")),
              );
            } else if (state is AuthenticationFailure) {
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
                SizedBox(height: 80.h),

                // Image, centered horizontally
                Center(
                  child: Image.asset(
                    "assets/images/login.png",
                    height: 80.h,
                    width: 80.w,
                  ),
                ),
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: InterText.text("Login", FontWeight.w600, 30.sp),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: InterText.text(
                      "Login to continue using the app", FontWeight.w400, 16.sp,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Navigate to forgot password page
                              },
                              child: InterText.text(
                                "Forgot Password?",
                                FontWeight.w500,
                                16.sp,
                                color: AppColors.primaryButtonColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.h),
                      GestureDetector(
                        onTap: (){
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthenticationBloc>().add(
                              LoginEvent(
                                email: _email.text,
                                password: _password.text,
                              ),
                            );
                          }
                        },
                          child: const CustomButton(text: "Login"))
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
