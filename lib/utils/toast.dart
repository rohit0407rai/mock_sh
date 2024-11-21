import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'app_colors.dart';

void toast(String message, bool isPositive) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor:
    isPositive ? AppColors.primaryButtonColor : Colors.orange.shade400,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
