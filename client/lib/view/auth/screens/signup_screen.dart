import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:homelyf_services/res/widgets/custom_button.dart';
import 'package:homelyf_services/res/widgets/custom_textfield.dart';
import 'package:homelyf_services/utils/global_variables.dart';
import 'package:homelyf_services/utils/utils.dart';
import 'package:homelyf_services/view/auth/screens/signin_screen.dart';
import 'package:homelyf_services/view/auth/services/auth_service.dart';

enum Auth { signup }

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup-screen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  final _signUpFormKey = GlobalKey<FormState>();
  final _otpUserFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
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

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      mobile: _mobileController.text,
      otp: _otpController.text,
    );
  }

  void sendOtp() async {
    bool isOtpSent = await authService.sendOTP(
        context, _emailController.text, _mobileController.text);
    setState(() {
      _isOtpSent = isOtpSent; // Set the flag to indicate OTP has been sent
    });
  }

  void verifyEmail() {
    authService
        .verifyOTP(context, _emailController.text, _otpController.text)
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
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 10.0),
          //   child: TextButton.icon(
          //     style: ButtonStyle(
          //       elevation: MaterialStateProperty.all(4.0),
          //     ),
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) {
          //             return const SignInScreen();
          //           },
          //         ),
          //       );
          //     },
          //     icon: const Icon(
          //       Icons.arrow_back,
          //       size: 13,
          //       color: GlobalVariables.greyBackgroundColor,
          //     ),
          //     label: const Text(
          //       'Back to Sign In',
          //       style: TextStyle(
          //         fontSize: 12,
          //         fontWeight: FontWeight.w200,
          //         color: GlobalVariables.greyBackgroundColor,
          //         decoration: TextDecoration.underline,
          //         decorationColor: GlobalVariables.greyBackgroundColor,
          //       ),
          //     ),
          //   ),
          // ),
          Transform.translate(
            offset: const Offset(-50, 50),
            child: Container(
              height: MediaQuery.of(context).size.width / 1.5,
              width: MediaQuery.of(context).size.width / 1.5,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  alignment: FractionalOffset.topLeft,
                  image: AssetImage(
                    'assets/images/hammer.png',
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width / 1.2,
                MediaQuery.of(context).size.width / 8),
            child: Container(
              height: MediaQuery.of(context).size.width / 4,
              width: MediaQuery.of(context).size.width / 4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  alignment: FractionalOffset.topRight,
                  image: AssetImage(
                    'assets/images/nail.png',
                  ),
                ),
              ),
            ),
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
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
                                    'Sign Up',
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700,
                                      color: GlobalVariables.titleColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextField(
                                    controller: _nameController,
                                    hintText: 'Enter Name',
                                    labelText: 'Name',
                                    semanticsLabel: 'Buyers Name SignUp Input',
                                    customValidator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Name';
                                      }
                                      String namePattern =
                                          r'^[a-zA-Z\ ]{1,30}$';
                                      RegExp regExp = RegExp(namePattern);

                                      if (!regExp.hasMatch(value)) {
                                        return 'Please enter a valid name with a maximum length of 30 characters, only letters(a-z, A-Z) are allowed.';
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
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
                                      visible: _isEmailValid,
                                      child: _isEmailVerified
                                          ? const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10.0),
                                              child: Icon(
                                                Icons.verified_rounded,
                                                color: Colors.green,
                                                size: 20,
                                              ),
                                            )
                                          : Visibility(
                                              visible:
                                                  _isEmailValid && !_isOtpSent,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0),
                                                child: TextButton(
                                                  child: Text(
                                                    'Verify',
                                                    style: TextStyle(
                                                      color: _isOtpSent
                                                          ? Colors.grey
                                                          : Theme.of(context)
                                                              .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    if (_isEmailValid) {
                                                      sendOtp();
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Form(
                                    key: _otpUserFormKey,
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
                                    visible: _isOtpSent,
                                    child: TextButton(
                                      onPressed: () {
                                        if (_isOtpSent) {
                                          if (_otpUserFormKey.currentState!
                                              .validate()) {
                                            verifyEmail();
                                          }
                                        }
                                      },
                                      child: Text(
                                        'Verify Email',
                                        style: TextStyle(
                                          color: _isEmailVerified
                                              ? Colors
                                                  .grey // Change the color if OTP has been sent
                                              : Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CustomTextField(
                                    controller: _mobileController,
                                    hintText: 'Enter Mobile Number',
                                    labelText: 'Mobile No.',
                                    semanticsLabel:
                                        'Buyers Mobile SignUp Input',
                                    customValidator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Mobile No.';
                                      }
                                      String namePattern = r'^\d{10}$';
                                      RegExp regExp = RegExp(namePattern);

                                      if (!regExp.hasMatch(value)) {
                                        return 'Please enter a valid mobile number';
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  CustomTextField(
                                    controller: _passwordController,
                                    labelText: 'Password',
                                    hintText: 'Enter Password',
                                    semanticsLabel:
                                        'Buyers Password SignUp Input',
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
                                  CustomTextField(
                                    controller: _confirmPasswordController,
                                    labelText: 'Confirm Password',
                                    hintText: 'Enter Confirm Password',
                                    semanticsLabel:
                                        'Buyers Confirm Password SignUp Input',
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
                                          _confirmPasswordController.text);
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
                                    text: 'Sign Up',
                                    gradient: GlobalVariables.buttonGradient,
                                    elevation: 8,
                                    onTap: () {
                                      if (_signUpFormKey.currentState!
                                          .validate()) {
                                        // Check if passwords match
                                        if (!_isEmailVerified) {
                                          Utils.snackBarErrorMessage(context,
                                              'Please verify Email Address');
                                        }
                                        if (_passwordController.text !=
                                            _confirmPasswordController.text) {
                                          Utils.snackBarErrorMessage(context,
                                              'Passwords do not match. Please make sure both passwords are identical.');
                                        } else {
                                          // Passwords match, call forgotPassword function
                                          signUpUser();
                                        }
                                      }

                                      // if (!_isEmailVerified) {
                                      //    Utils.snackBarErrorMessage(context,
                                      //       'Please verify Email Address');
                                      // } else if (_signUpFormKey.currentState!
                                      //     .validate()) {
                                      //   signUpUser();
                                      // }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Already have an account?',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color.fromARGB(255, 95, 94, 94),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const SignInScreen();
                                          }));
                                        },
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                              EdgeInsetsGeometry>(
                                            const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 4),
                                          ),
                                        ),
                                        child: const Text(
                                          'Sign In',
                                          style: TextStyle(
                                            color: GlobalVariables.titleColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: Color.fromARGB(
                                                255, 96, 173, 211),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // const SizedBox(height: 30),
                                  // Align(
                                  //   alignment: FractionalOffset.bottomCenter,
                                  //   child: TextButton(
                                  //     style: ButtonStyle(
                                  //       backgroundColor:
                                  //           MaterialStateProperty.all<Color>(
                                  //               const Color.fromARGB(
                                  //                   255, 230, 239, 254)),
                                  //       shape: MaterialStateProperty.all<
                                  //           OutlinedBorder>(
                                  //         RoundedRectangleBorder(
                                  //           borderRadius: BorderRadius.circular(
                                  //               10.0), // Adjust the border radius as needed
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     onPressed: () {
                                  //       Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //           builder: (context) {
                                  //             return const SignUpPartner();
                                  //           },
                                  //         ),
                                  //       );
                                  //     },
                                  //     child: const Text(
                                  //       'Sign Up As A Service Provider',
                                  //       style: TextStyle(
                                  //         color: GlobalVariables.titleColor,
                                  //         fontSize: 15,
                                  //         fontWeight: FontWeight.w600,
                                  //         // decoration: TextDecoration.underline,
                                  //         // decorationColor:
                                  //         //     GlobalVariables.titleColor,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
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
