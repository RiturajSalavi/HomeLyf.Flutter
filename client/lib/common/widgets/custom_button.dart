// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:homelyf_services/constants/global_variables.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Gradient? gradient;
  final VoidCallback onTap;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;
  final double? elevation;
  final bool visible;

  const CustomButton({
    Key? key,
    required this.text,
    this.backgroundColor,
    required this.onTap,
    this.width,
    this.height,
    this.borderRadius,
    this.elevation,
    this.visible = true,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color buttonColor = backgroundColor ?? GlobalVariables.secondaryColor;
    final borderRadius = this.borderRadius ?? BorderRadius.circular(8);
    return Visibility(
      visible: visible,
      child: Container(
        width: width,
        height: height ?? 50,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.6),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, height ?? 50),
            backgroundColor:
                gradient == null ? buttonColor : Colors.transparent,
            shadowColor: gradient == null
                ? GlobalVariables.greyBackgroundColor
                : Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            elevation: elevation ?? 0,
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
