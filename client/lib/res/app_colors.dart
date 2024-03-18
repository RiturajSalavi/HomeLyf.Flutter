import 'package:flutter/material.dart';

class AppColors {
  static const Color blackColor = Colors.black;
  static const Color whiteColor = Colors.white;
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 213, 222, 239),
      Color.fromARGB(255, 213, 222, 239),
    ],
    stops: [0.5, 1.0],
  );
  static const buttonGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 130, 188, 254),
      Color.fromARGB(255, 38, 112, 216),
    ],
    stops: [0.3, 1.0],
  );

  static const secondaryColor = Color.fromARGB(255, 86, 145, 255);
  static const backgroundColor = Colors.white;
  static const titleColor = Color.fromARGB(255, 76, 139, 198);
  static const subTitleColor = Color.fromARGB(255, 73, 104, 141);
  static const textColor = Color.fromARGB(255, 119, 123, 130);
  static const labelColor = Color.fromARGB(255, 147, 147, 147);
  static const hintColor = Color.fromARGB(255, 147, 147, 147);
  static const Color greyBackgroundColor = Color.fromARGB(255, 122, 122, 122);
  static var selectedNavBarColor = const Color.fromARGB(255, 75, 141, 198);
  static const unselectedNavBarColor = Colors.black87;
}
