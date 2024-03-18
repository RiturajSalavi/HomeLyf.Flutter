import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:homelyf_services/res/widgets/custom_button.dart';
import 'package:homelyf_services/res/widgets/custom_textfield.dart';
import 'package:homelyf_services/utils/global_variables.dart';
import 'package:homelyf_services/utils/utils.dart';
import 'package:homelyf_services/view/partner/screens/signin_partner.dart';
import 'package:homelyf_services/view/partner/services/partner_auth_service.dart';

class SignUpPartner extends StatefulWidget {
  static const String routeName = '/signup-partner';
  const SignUpPartner({super.key});

  @override
  State<SignUpPartner> createState() => _SignUpPartnerState();
}

class _SignUpPartnerState extends State<SignUpPartner>
    with TickerProviderStateMixin {
  final _signUpPartnerFormKey = GlobalKey<FormState>();
  final _otpPartnerFormKey = GlobalKey<FormState>();
  final PartnerAuthService partnerAuthService = PartnerAuthService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  List<Map<String, String>> _selectedServiceCategories = [];
  List<Map<String, String>>? _allServiceCategories;

  bool _passwordObscured = true;
  bool _confirmPasswordObscured = true;
  bool _isOtpSent = false;
  bool _isEmailVerified = false;
  bool _isEmailValid = false;
  bool _showCategoryError = false;

  @override
  void initState() {
    super.initState();

    // Manually assign choices for testing
    _allServiceCategories = ([
      {'description': 'homelyf cleaning', 'name': 'cleaning'},
      {'description': 'homelyf printing', 'name': 'printing'},
      {'description': 'homelyf gardening', 'name': 'gardening'},
      {'description': 'homelyf cleaning', 'name': 'repairing'},
      {'description': 'homelyf printing', 'name': 'electrician'},
      {'description': 'homelyf gardening', 'name': 'painting'},
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _mobileController.dispose();
  }

  void signUpPartner() {
    partnerAuthService.partnerSignUp(
      context: context,
      name: _nameController.text,
      email: _emailController.text,
      mobile: _mobileController.text,
      otp: _otpController.text,
      aadharCard: _aadharController.text,
      address: _addressController.text,
      experience: _experienceController.text,
      password: _passwordController.text,
      serviceCategory: _selectedServiceCategories,
    );
  }

  void sendOtp() async {
    bool isOtpSent = await partnerAuthService.partnerSendOTP(
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
                            key: _signUpPartnerFormKey,
                            child: Column(
                              children: [
                                Container(
                                  color:
                                      const Color.fromARGB(154, 255, 255, 255),
                                  child: const Text(
                                    'Be a Partner',
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 145, 203),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomTextField(
                                  controller: _nameController,
                                  hintText: 'Enter Name',
                                  labelText: 'Name',
                                  semanticsLabel:
                                      'Service Provider Name SignUp Input',
                                  customValidator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Name';
                                    }
                                    String namePattern = r'^[a-zA-Z\ ]{1,30}$';
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
                                  semanticsLabel:
                                      'Service Provider Email SignUp Input',
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
                                                    fontWeight: FontWeight.w600,
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
                                  key: _otpPartnerFormKey,
                                  child: CustomTextField(
                                    controller: _otpController,
                                    labelText: 'OTP',
                                    hintText: 'Enter OTP',
                                    semanticsLabel:
                                        'Service Provider OTP SignUp Input',
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
                                        if (_otpPartnerFormKey.currentState!
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
                                      'Service Provider Mobile SignUp Input',
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
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        List<Map<String, String>> categories =
                                            _allServiceCategories!;
                                        List<Map<String, String>>
                                            selectedCategories = List.from(
                                                _selectedServiceCategories);

                                        await showModalBottomSheet(
                                          context: context,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8.0),
                                              topRight: Radius.circular(8.0),
                                            ),
                                          ),
                                          builder: (context) {
                                            return StatefulBuilder(
                                              builder: (BuildContext context,
                                                  StateSetter setState) {
                                                return SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20.0),
                                                        child: GridView.builder(
                                                          shrinkWrap: true,
                                                          gridDelegate:
                                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 2,
                                                            childAspectRatio: 4,
                                                            mainAxisSpacing:
                                                                10.0,
                                                            crossAxisSpacing:
                                                                10.0,
                                                          ),
                                                          itemCount:
                                                              categories.length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            Map<String, String>
                                                                category =
                                                                categories[
                                                                    index];
                                                            bool isSelected =
                                                                selectedCategories
                                                                    .contains(
                                                                        category);

                                                            return GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  if (isSelected) {
                                                                    selectedCategories
                                                                        .remove(
                                                                            category);
                                                                  } else {
                                                                    _showCategoryError =
                                                                        false;
                                                                    selectedCategories
                                                                        .add(
                                                                            category);
                                                                  }
                                                                });
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: isSelected
                                                                      ? Colors
                                                                          .blue
                                                                          .withOpacity(
                                                                              0.5)
                                                                      : null,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: isSelected
                                                                        ? Colors
                                                                            .blue
                                                                        : Colors
                                                                            .grey[400]!,
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    category[
                                                                        'name']!,
                                                                    style:
                                                                        TextStyle(
                                                                      color: isSelected
                                                                          ? Colors
                                                                              .white
                                                                          : null,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ).then((value) {
                                          if (value == null) {
                                            setState(() {
                                              _selectedServiceCategories =
                                                  selectedCategories;
                                            });
                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 17.0, horizontal: 15.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            width: 1.5,
                                            color: _showCategoryError
                                                ? const Color.fromARGB(
                                                    255, 180, 4, 36)
                                                : const Color.fromARGB(
                                                    255, 218, 234, 254),
                                          ),
                                          color: const Color.fromARGB(
                                              255, 247, 250, 255),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Visibility(
                                              visible:
                                                  _selectedServiceCategories
                                                      .isEmpty,
                                              child: const Text(
                                                'Select Service Categories',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 138, 142, 149),
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible:
                                                  _selectedServiceCategories
                                                      .isNotEmpty,
                                              child: Wrap(
                                                spacing: 8.0,
                                                runSpacing: 8.0,
                                                children:
                                                    _selectedServiceCategories
                                                        .map(
                                                          (e) => Chip(
                                                            backgroundColor:
                                                                GlobalVariables
                                                                    .secondaryColor,
                                                            shape:
                                                                const RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    8),
                                                              ),
                                                            ),
                                                            side:
                                                                const BorderSide(
                                                              color: GlobalVariables
                                                                  .secondaryColor,
                                                            ),
                                                            label: Text(
                                                              e['name']!,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _showCategoryError,
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 15.0, top: 8.0),
                                        child: Text(
                                          'Please select at least one service category.',
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 180, 4,
                                                36), // Change color as needed
                                            fontSize:
                                                12.0, // Adjust font size as needed
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                // CustomTextField(
                                //   controller: _selectedServiceCategories,
                                //   hintText: 'Select Service Categories',
                                //   labelText: 'Service Categories',
                                //   semanticsLabel:
                                //       'Service Provider Categories SignUp Input',
                                //   customValidator: (value) {
                                //     if (value == null || value.isEmpty) {
                                //       return 'Please Select Service Categories';
                                //     }
                                //     return null;
                                //   },
                                // ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomTextField(
                                  controller: _aadharController,
                                  hintText: 'Enter Aadhar No.',
                                  labelText: 'Aadhar No.',
                                  semanticsLabel:
                                      'Service Provider Aadhar No. SignUp Input',
                                  customValidator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Aadhar No.';
                                    }
                                    String namePattern = r'^\d{12}$';
                                    RegExp regExp = RegExp(namePattern);

                                    if (!regExp.hasMatch(value)) {
                                      return 'Please enter a valid Aadhar No.';
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomTextField(
                                  controller: _addressController,
                                  hintText: 'Enter Address',
                                  labelText: 'Address',
                                  semanticsLabel:
                                      'Service Provider Address SignUp Input',
                                  customValidator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Address';
                                    }
                                    String namePattern = r'[a-zA-Z0-9\ .,/]$';
                                    RegExp regExp = RegExp(namePattern);

                                    if (!regExp.hasMatch(value)) {
                                      return 'Please enter a valid Address';
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomTextField(
                                  controller: _experienceController,
                                  hintText: 'Enter Years of Experience',
                                  labelText: 'Years of Experience',
                                  semanticsLabel:
                                      'Service Provider Years of Experience SignUp Input',
                                  customValidator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Years of Experience';
                                    }
                                    String namePattern = r'^[0-9\ ]{1,2}$';
                                    RegExp regExp = RegExp(namePattern);

                                    if (!regExp.hasMatch(value)) {
                                      return 'Please enter your experience in years.';
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
                                      'Service Provider Password SignUp Input',
                                  obscureText: _passwordObscured,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: IconButton(
                                      icon: Icon(
                                        _passwordObscured
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color:
                                            const Color.fromARGB(136, 0, 0, 0),
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
                                  hintText: 'Re-enter Password',
                                  semanticsLabel:
                                      'Service Provider Password SignUp Input',
                                  obscureText: _confirmPasswordObscured,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: IconButton(
                                      icon: Icon(
                                        _confirmPasswordObscured
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color:
                                            const Color.fromARGB(136, 0, 0, 0),
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
                                      return 'Please Re-enter Password';
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
                                    if (_selectedServiceCategories.isEmpty) {
                                      setState(() {
                                        _showCategoryError = true;
                                      });
                                    }
                                    if (_signUpPartnerFormKey.currentState!
                                            .validate() &&
                                        _showCategoryError) {
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
                                        signUpPartner();
                                      }
                                    }
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 95, 94, 94),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const SignInPartner();
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
                                          color:
                                              Color.fromARGB(255, 96, 173, 211),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              Color.fromARGB(255, 96, 173, 211),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Align(
                                //   alignment: Alignment.bottomCenter,
                                //   child: TextButton(
                                //     child: const Text(
                                //       'Sign Up As A Buyer',
                                //       style: TextStyle(
                                //         fontSize: 15,
                                //         fontWeight: FontWeight.w500,
                                //         color: GlobalVariables.secondaryColor,
                                //       ),
                                //     ),
                                //     onPressed: () {
                                //       Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context) {
                                //             return const SignUpScreen();
                                //           },
                                //         ),
                                //       );
                                //     },
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
