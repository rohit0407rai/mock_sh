import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class InterText {
  static Text text(String s, FontWeight weight, double size,
      {Color? color,
        TextAlign? align,
        Shadow? shadow,
        TextDecoration? decoration,
        double? letterspace}) {
    return Text(
      s,
      textAlign: align,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: color ?? AppColors.primaryTextColor,
          fontWeight: weight,
          letterSpacing: letterspace,
          decoration: decoration ?? TextDecoration.none,
          shadows: [
            shadow ??
                Shadow(
                  offset: const Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  color: const Color.fromARGB(8, 0, 0, 0).withOpacity(0.0),
                ),
          ],
          fontSize: size,
        ),
      ),
    );
  }
}
