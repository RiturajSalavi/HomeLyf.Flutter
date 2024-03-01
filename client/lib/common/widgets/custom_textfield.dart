// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:homelyf_services/constants/global_variables.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String? semanticsLabel;
  final int maxLines;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? customValidator;
  final bool visible;
  final bool enabled;
  final void Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.semanticsLabel,
    this.maxLines = 2,
    this.obscureText = false,
    this.suffixIcon,
    this.customValidator,
    this.visible = true,
    this.enabled = true,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode focusNode;
  late Color labelColor;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    labelColor = GlobalVariables.labelColor;
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            // Update label text color based on focus state
            // Here, I'm using blue when focused and black when not focused
            labelColor = hasFocus
                ? GlobalVariables.secondaryColor
                : GlobalVariables.textColor;
          });
        },
        child: TextFormField(
          onChanged: widget.onChanged,
          enabled: widget.enabled,
          controller: widget.controller,
          obscureText: widget.obscureText,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: GlobalVariables.hintColor,
              fontWeight: FontWeight.normal,
              fontSize: 15,
            ),
            labelText: widget.labelText,
            labelStyle: TextStyle(
              color: labelColor, // Use the dynamically set label color
              fontSize: 15,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
            filled: true,
            fillColor: const Color.fromARGB(255, 247, 250, 255),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 234, 242, 250),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 218, 234, 254),
                width: 1.5,
              ),
            ),
            suffixIcon: widget.suffixIcon,
            semanticCounterText: widget.semanticsLabel,
            errorMaxLines: 5,
          ),
          validator: widget.customValidator ??
              (val) {
                if (val == null || val.isEmpty) {
                  return 'Please ${widget.hintText}';
                }
                return null;
              },
        ),
      ),
    );
  }
}
