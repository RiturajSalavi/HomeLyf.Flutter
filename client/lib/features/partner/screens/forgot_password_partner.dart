import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:homelyf_services/common/widgets/custom_button.dart';
import 'package:homelyf_services/common/widgets/custom_textfield.dart';
import 'package:homelyf_services/constants/global_variables.dart';
import 'package:homelyf_services/constants/utils.dart';
import 'package:homelyf_services/features/partner/screens/signin_partner.dart';
import 'package:homelyf_services/features/partner/services/partner_auth_service.dart';

class ForgotPasswordPartner extends StatefulWidget {
  static const String routeName = '/forgot-password-partner';
  const ForgotPasswordPartner({super.key});

  @override
  State<ForgotPasswordPartner> createState() => _ForgotPasswordPartnerState();
}

class _ForgotPasswordPartnerState extends State<ForgotPasswordPartner>
    with TickerProviderStateMixin {
  final _signUpFormKey = GlobalKey<FormState>();
  final _otpFormKey = GlobalKey<FormState>();
  final PartnerAuthService partnerAuthService = PartnerAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _passwordObscured = true;
  bool _confirmPasswordObscured = true;
  bool _isOtpSent = false;
  bool _isEmailVerified = false;
  bool _isEmailValid = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _mobileController.dispose();
  }

  void forgotPassword() {
    partnerAuthService.partnerForgotPassword(
      context: context,
      email: _emailController.text,
      newPassword: _passwordController.text,
      otp: _otpController.text,
    );
  }

  void sendOTPForgotPassword() async {
    bool isOtpSent = await partnerAuthService.partnerSendOTPForgotPassword(
        context, _emailController.text, _mobileController.text);
    setState(() {
      _isOtpSent = isOtpSent; // Set the flag to indicate OTP has been sent
    });
  }

  void verifyEmail() {
    partnerAuthService
        .partnerVerifyOTP(context, _emailController.text, _otpController.text)
        .then((result) {
      if (result) {
        // Email verification successful
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email Verified Successfully"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
        ));
        setState(() {
          _isEmailVerified = true;
          _isOtpSent = false;
        });
      } else {
        // Email verification failed
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Invalid OTP! Please enter a valid OTP."),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const SignInPartner();
                  }));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 13,
                  color: GlobalVariables.greyBackgroundColor,
                ),
                label: const Text(
                  'Back to Sign In',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w200,
                    color: GlobalVariables.greyBackgroundColor,
                    decoration: TextDecoration.underline,
                    decorationColor: GlobalVariables.greyBackgroundColor,
                  ),
                )),
          ),
          // Image.asset(
          //   'assets/images/hello.jpg', // Replace with your image path
          //   fit: BoxFit.cover,
          //   height: MediaQuery.of(context).size.height,
          // ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // const Text(
                      //   'Welcome to HomeLyf',
                      //   style: TextStyle(
                      //     fontSize: 50,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.15,
                      // ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            color: const Color.fromARGB(0, 255, 255, 255),
                            child: Form(
                              key: _signUpFormKey,
                              child: Column(
                                children: [
                                  const Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 145, 203),
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.center,
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      children: [
                                        Text(
                                          "No worries! We've got you covered.\nTo reset your password, please enter the email address associated with your account. We'll send you a secure link to create a new password.",
                                          style: TextStyle(fontSize: 13.0),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextField(
                                    controller: _emailController,
                                    labelText: 'Email Address',
                                    hintText: 'Enter Email Address',
                                    enabled: !_isEmailVerified,
                                    semanticsLabel: 'Buyers Email SignUp Input',
                                    customValidator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Email Address';
                                      }
                                      String emailPattern =
                                          r'^[a-z0-9\.]+@([a-z0-9]+\.)+[a-z0-9]{2,320}$';
                                      RegExp regExp = RegExp(emailPattern);

                                      if (!regExp.hasMatch(value)) {
                                        _isEmailValid = true;
                                        return 'Please enter a valid email address, only contain letters(a-z), number(0-9), and periods(.) are allowed.';
                                      }

                                      return null;
                                    },
                                    onChanged: (value) {
                                      String emailPattern =
                                          r'^[a-z0-9\.]+@([a-z0-9]+\.)+[a-z0-9]{2,320}$';
                                      RegExp regExp = RegExp(emailPattern);

                                      if (regExp.hasMatch(value)) {
                                        _isEmailValid = true;
                                        setState(() {
                                          _isOtpSent = false;
                                        });
                                      }
                                    },
                                    suffixIcon: Visibility(
                                      visible: _isEmailVerified,
                                      child: const Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: Icon(
                                          Icons.verified_rounded,
                                          color: Colors.green,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Visibility(
                                    visible: !_isEmailVerified && !_isOtpSent,
                                    child: CustomButton(
                                      visible: _isEmailValid,
                                      text: 'Send OTP',
                                      gradient: GlobalVariables.buttonGradient,
                                      elevation: 8,
                                      onTap: () {
                                        if (_isEmailValid) {
                                          sendOTPForgotPassword();
                                        }
                                      },
                                    ),
                                  ),
                                  Form(
                                    key: _otpFormKey,
                                    child: CustomTextField(
                                      controller: _otpController,
                                      labelText: 'OTP',
                                      hintText: 'Enter OTP',
                                      semanticsLabel: 'Buyers OTP SignUp Input',
                                      visible: _isOtpSent,
                                      customValidator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter OTP';
                                        }
                                        String namePattern = r'^\d{4}$';
                                        RegExp regExp = RegExp(namePattern);

                                        if (!regExp.hasMatch(value)) {
                                          return 'Please enter a valid OTP. Only 4-digits allowed';
                                        }

                                        return null;
                                      },
                                    ),
                                  ),
                                  Visibility(
                                    visible: !_isEmailVerified && _isOtpSent,
                                    child: const SizedBox(
                                      height: 15,
                                    ),
                                  ),
                                  Visibility(
                                    visible: !_isEmailVerified && _isOtpSent,
                                    child: CustomButton(
                                      visible: _isOtpSent,
                                      text: 'Verify OTP',
                                      gradient: GlobalVariables.buttonGradient,
                                      elevation: 8,
                                      onTap: () {
                                        if (_isOtpSent) {
                                          if (_otpFormKey.currentState!
                                              .validate()) {
                                            verifyEmail();
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                  // Visibility(
                                  //   visible: _isOtpSent,
                                  //   child: TextButton(
                                  //     onPressed:
                                  //         _isOtpSent ? verifyEmail : null,
                                  //     child: Text(
                                  //       'Verify OTP',
                                  //       style: TextStyle(
                                  //         color: _isEmailVerified
                                  //             ? Colors
                                  //                 .grey // Change the color if OTP has been sent
                                  //             : Theme.of(context).primaryColor,
                                  //         fontWeight: FontWeight.w600,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),

                                  CustomTextField(
                                    visible: _isEmailVerified,
                                    controller: _passwordController,
                                    labelText: 'New Password',
                                    hintText: 'Enter New Password',
                                    semanticsLabel:
                                        'Buyers New Password SignUp Input',
                                    obscureText: _passwordObscured,
                                    suffixIcon: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: IconButton(
                                        icon: Icon(
                                          _passwordObscured
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: const Color.fromARGB(
                                              136, 0, 0, 0),
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _passwordObscured =
                                                !_passwordObscured;
                                          });
                                        },
                                      ),
                                    ),
                                    customValidator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter New Password';
                                      }
                                      String errorMessages = validatePassword(
                                          _passwordController.text);
                                      if (errorMessages.isNotEmpty) {
                                        return errorMessages;
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                  CustomTextField(
                                    visible: _isEmailVerified,
                                    controller: _confirmPasswordController,
                                    labelText: 'Confirm Password',
                                    hintText: 'Enter Password',
                                    semanticsLabel:
                                        'Buyers Password SignUp Input',
                                    obscureText: _confirmPasswordObscured,
                                    suffixIcon: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: IconButton(
                                        icon: Icon(
                                          _confirmPasswordObscured
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: const Color.fromARGB(
                                              136, 0, 0, 0),
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _confirmPasswordObscured =
                                                !_confirmPasswordObscured;
                                          });
                                        },
                                      ),
                                    ),
                                    customValidator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Password';
                                      }
                                      String errorMessages = validatePassword(
                                          _passwordController.text);
                                      if (errorMessages.isNotEmpty) {
                                        return errorMessages;
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  CustomButton(
                                    visible: _isEmailVerified,
                                    text: 'Change Password',
                                    gradient: GlobalVariables.buttonGradient,
                                    elevation: 8,
                                    onTap: () {
                                      if (!_isEmailVerified) {
                                        return showSnackBar(context,
                                            'Please verify Email Address');
                                      } else if (_signUpFormKey.currentState!
                                          .validate()) {
                                        // Check if passwords match
                                        if (_passwordController.text !=
                                            _confirmPasswordController.text) {
                                          showSnackBar(context,
                                              'Passwords do not match. Please make sure both passwords are identical.');
                                        } else {
                                          // Passwords match, call forgotPassword function
                                          forgotPassword();
                                        }
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, MediaQuery.of(context).size.height - 120),
            child: Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.contain,
                alignment: FractionalOffset.topLeft,
                image: AssetImage(
                  'assets/images/sofaset.png',
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }

  String validatePassword(String password) {
    List<String> errors = [];

    // Check for minimum length
    if (password.length < 8) {
      errors.add("at least 8 characters");
    }

    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      errors.add("at least one uppercase letter");
    }

    // Check for at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      errors.add("at least one lowercase letter");
    }

    // Check for at least one digit
    if (!RegExp(r'\d').hasMatch(password)) {
      errors.add("at least one digit");
    }

    // Check for at least one special character
    if (!RegExp(r'[!@#$%^&*()-_+=<>?/[\]{}|]').hasMatch(password)) {
      errors.add("at least one special character");
    }

    if (password.contains(' ')) {
      errors.add("no spaces");
    }

    if (password.length > 14) {
      errors.add("at most 14 characters");
    }

    // Concatenate error messages
    String errorMessages = errors.join(', ');

    // Return result
    if (errorMessages.isNotEmpty) {
      return "Password must contain $errorMessages.";
    }
    return '';
  }
}
