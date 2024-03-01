// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:homelyf_services/constants/error_handling.dart';
import 'package:homelyf_services/constants/global_variables.dart';
import 'package:homelyf_services/constants/utils.dart';
import 'package:homelyf_services/features/auth/screens/signin_screen.dart';
import 'package:homelyf_services/features/partner/screens/partner_screen.dart';
import 'package:homelyf_services/features/partner/screens/signin_partner.dart';
import 'package:homelyf_services/models/partner.dart';
import 'package:homelyf_services/providers/partner_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PartnerAuthService {
  Future<bool> partnerSendOTP(
    BuildContext context,
    String email,
    String mobile,
  ) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/sp/sendEmail-otp-partner'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': email, 'mobile': mobile}),
      );

      final data = jsonDecode(res.body);
      if (res.statusCode == 200 && data != null) {
        showSnackBar(context, 'OTP sent successfully!');
        return true;
      } else if (res.statusCode == 400 && data != null) {
        showSnackBar(context,
            'User with same email or mobile no. already exists!\nTry using different email or mobile no.');
        return false;
      } else {
        showSnackBar(context, 'Failed to send OTP.');
        return false;
      }
    } on SocketException catch (e) {
      // Handle SocketException (connection error)
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        // No internet connection
        showSnackBar(context, 'No internet connection.');
        return false;
      } else {
        // Connection error (other than no internet)
        showSnackBar(context, 'Connection error: ${e.message}');
        return false;
      }
    } on http.ClientException catch (e) {
      // Handle DioError (Dio-specific exception)
      showSnackBar(context, 'HTTP request failed: ${e.message}');
      return false;
    } catch (e) {
      showSnackBar(context, e.toString());
      return false;
    }
  }

  Future<bool> partnerSendOTPForgotPassword(
    BuildContext context,
    String email,
    String mobile,
  ) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/sp/sendEmail-forgotPassword-otp-partner'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': email, 'mobile': mobile}),
      );

      final data = jsonDecode(res.body);
      if (res.statusCode == 200 && data != null) {
        showSnackBar(context, 'OTP sent successfully!');
        return true;
      } else if (res.statusCode == 400 && data != null) {
        showSnackBar(context, "User with this email doesn't exist!");
        return false;
      } else {
        showSnackBar(context, 'Failed to send OTP.');
        return false;
      }
    } on SocketException catch (e) {
      // Handle SocketException (connection error)
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        // No internet connection
        showSnackBar(context, 'No internet connection.');
        return false;
      } else {
        // Connection error (other than no internet)
        showSnackBar(context, 'Connection error: ${e.message}');
        return false;
      }
    } on http.ClientException catch (e) {
      // Handle DioError (Dio-specific exception)
      showSnackBar(context, 'HTTP request failed: ${e.message}');
      return false;
    } catch (e) {
      showSnackBar(context, e.toString());
      return false;
    }
  }

  Future<bool> partnerVerifyOTP(
    BuildContext context,
    String email,
    String otp,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$uri/sp/verify-otp-partner'),
        body: jsonEncode({
          'email': email,
          'otp': otp,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        // OTP verification successful
        return true;
      } else {
        // OTP verification failed
        return false;
      }
    } on SocketException catch (e) {
      // Handle SocketException (connection error)
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        // No internet connection
        showSnackBar(context, 'No internet connection.');
        return false;
      } else {
        // Connection error (other than no internet)
        showSnackBar(context, 'Connection error: ${e.message}');
        return false;
      }
    } on http.ClientException catch (e) {
      // Handle DioError (Dio-specific exception)
      showSnackBar(context, 'HTTP request failed: ${e.message}');
      return false;
    } catch (error) {
      // Handle network or other errors
      return false;
    }
  }

  // sign up user
  void partnerSignUp({
    required BuildContext context,
    required String name,
    required String email,
    required String mobile,
    required String otp,
    required String aadharCard,
    required String address,
    required String experience,
    required String password,
    required List<Map<String, String>> serviceCategory,
  }) async {
    try {
      Partner partner = Partner(
        id: '',
        name: name,
        email: email,
        mobile: mobile,
        otp: otp,
        aadharCard: aadharCard,
        address: address,
        experience: experience,
        serviceCategory: serviceCategory,
        password: password,
        type: '',
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/sp/signup-partner'),
        body: partner.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBar(
            context,
            "Welcome, ${partner.name}! Your home, our priority. Let's get things done!",
          );
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<PartnerProvider>(context, listen: false)
              .setPartner(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            PartnerScreen.routeName,
            (route) => false,
          );
        },
      );
    } on SocketException catch (e) {
      // Handle SocketException (connection error)
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        // No internet connection
        showSnackBar(context, 'No internet connection.');
      } else {
        // Connection error (other than no internet)
        showSnackBar(context, 'Connection error: ${e.message}');
      }
    } on http.ClientException catch (e) {
      // Handle DioError (Dio-specific exception)
      showSnackBar(context, 'HTTP request failed: ${e.message}');
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // sign in user
  Future<void> partnerSignIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/sp/signin-partner'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<PartnerProvider>(context, listen: false)
              .setPartner(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          if (prefs.getString('x-auth-token') != null &&
              prefs.getString('x-auth-token')!.isNotEmpty) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Provider.of<PartnerProvider>(context, listen: false)
                                .partner
                                .type ==
                            'partner'
                        ? const PartnerScreen()
                        : const SignInPartner(),
              ),
              (route) => false,
            );
          }
        },
      );
    } on SocketException catch (e) {
      // Handle SocketException (connection error)
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        // No internet connection
        showSnackBar(context, 'No internet connection.');
      } else {
        // Connection error (other than no internet)
        showSnackBar(context, 'Connection error: ${e.message}');
      }
    } on http.ClientException catch (e) {
      // Handle DioError (Dio-specific exception)
      showSnackBar(context, 'HTTP request failed: ${e.message}');
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get user data
  Future<void> getPartnerData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/sp/tokenIsValid-partner'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response partnerRes = await http.get(
          Uri.parse('$uri/sp/get-partner-data'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var partner = Provider.of<PartnerProvider>(context, listen: false);
        partner.setPartner(partnerRes.body);
      }
    } on SocketException catch (e) {
      // Handle SocketException (connection error)
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        // No internet connection
        showSnackBar(context, 'No internet connection.');
      } else {
        // Connection error (other than no internet)
        showSnackBar(context, 'Connection error: ${e.message}');
      }
    } on http.ClientException catch (e) {
      // Handle DioError (Dio-specific exception)
      showSnackBar(context, 'HTTP request failed: ${e.message}');
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> partnerForgotPassword({
    required BuildContext context,
    required String email,
    required String newPassword,
    required String otp,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/sp/forgotpassword-partner'),
        body: jsonEncode({
          'email': email,
          'newPassword': newPassword,
          'otp': otp,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBar(context, 'Password Successfully Changed');
          Navigator.pushNamedAndRemoveUntil(
            context,
            SignInScreen.routeName,
            (route) => false,
          );
        },
      );
    } on SocketException catch (e) {
      // Handle SocketException (connection error)
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        // No internet connection
        showSnackBar(context, 'No internet connection.');
      } else {
        // Connection error (other than no internet)
        showSnackBar(context, 'Connection error: ${e.message}');
      }
    } on http.ClientException catch (e) {
      // Handle DioError (Dio-specific exception)
      showSnackBar(context, 'HTTP request failed: ${e.message}');
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Map<String, String>>> getServiceCategories() async {
    http.Response res = await http.get(Uri.parse('$uri/service-categories'));
    if (res.statusCode == 200) {
      final List<dynamic> categories = json.decode(res.body);
      return categories.cast<Map<String, String>>();
    } else {
      throw Exception('Failed to load service categories');
    }
  }
}
