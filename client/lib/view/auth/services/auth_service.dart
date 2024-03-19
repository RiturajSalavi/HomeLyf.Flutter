// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:homelyf_services/repository/auth_repository.dart';
import 'package:homelyf_services/res/widgets/bottom_bar.dart';
import 'package:homelyf_services/utils/error_handling.dart';
import 'package:homelyf_services/utils/global_variables.dart';
import 'package:homelyf_services/utils/routes/routes_name.dart';
import 'package:homelyf_services/utils/utils.dart';
import 'package:homelyf_services/view/admin/screens/admin_screen.dart';
import 'package:homelyf_services/models/user.dart';
import 'package:homelyf_services/view_model/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _myRepo = AuthRepository();
  Future<bool> sendOTP(
    BuildContext context,
    String email,
    String mobile,
  ) async {
    try {
      String apiData =
          jsonEncode(<String, String>{'email': email, 'mobile': mobile});
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8'
      };
      http.Response res = await _myRepo.sendOTP(apiData, headers);

      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/sendEmail-otp'),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      //   body: jsonEncode(<String, String>{'email': email, 'mobile': mobile}),
      // );

      final data = jsonDecode(res.body);
      if (res.statusCode == 200 && data != null) {
        Utils.snackBarSuccessMessage(context, 'OTP sent successfully!');
        return true;
      } else if (res.statusCode == 400 && data != null) {
        Utils.snackBarGeneralMessage(context,
            'User with same email or mobile no. already exists!\nTry using different email or mobile no.');
        return false;
      } else {
        Utils.snackBarErrorMessage(context, 'Failed to send OTP.');
        return false;
      }
    } on SocketException catch (e) {
      // Handle SocketException (connection error)
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        // No internet connection
        Utils.snackBarGeneralMessage(context, 'No internet connection.');
        return false;
      } else {
        // Connection error (other than no internet)
        Utils.snackBarErrorMessage(context, 'Connection error: ${e.message}');
        return false;
      }
    } on http.ClientException catch (e) {
      // Handle DioError (Dio-specific exception)
      Utils.snackBarErrorMessage(context, 'HTTP request failed: ${e.message}');
      return false;
    } catch (e) {
      Utils.snackBarErrorMessage(context, e.toString());
      return false;
    }
  }

  Future<bool> sendOTPForgotPassword(
    BuildContext context,
    String email,
    String mobile,
  ) async {
    try {
      String apiData =
          jsonEncode(<String, String>{'email': email, 'mobile': mobile});
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8'
      };
      http.Response res = await _myRepo.sendOTPForgotPassword(apiData, headers);

      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/sendEmail-forgotPassword-otp'),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      //   body: jsonEncode(<String, String>{'email': email, 'mobile': mobile}),
      // );

      final data = jsonDecode(res.body);
      if (res.statusCode == 200 && data != null) {
        Utils.snackBarSuccessMessage(context, 'OTP sent successfully!');
        return true;
      } else if (res.statusCode == 400 && data != null) {
        Utils.snackBarGeneralMessage(
            context, "User with this email doesn't exist!");
        return false;
      } else {
        Utils.snackBarErrorMessage(context, 'Failed to send OTP.');
        return false;
      }
    } on SocketException catch (e) {
      // Handle SocketException (connection error)
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        // No internet connection
        Utils.snackBarGeneralMessage(context, 'No internet connection.');
        return false;
      } else {
        // Connection error (other than no internet)
        Utils.snackBarErrorMessage(context, 'Connection error: ${e.message}');
        return false;
      }
    } on http.ClientException catch (e) {
      // Handle DioError (Dio-specific exception)
      Utils.snackBarErrorMessage(context, 'HTTP request failed: ${e.message}');
      return false;
    } catch (e) {
      Utils.snackBarErrorMessage(context, e.toString());
      return false;
    }
  }

  Future<bool> verifyOTP(
    BuildContext context,
    String email,
    String otp,
  ) async {
    try {
      String apiData = jsonEncode({
        'email': email,
        'otp': otp,
      });
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8'
      };
      http.Response response = await _myRepo.verifyOTP(apiData, headers);

      // final response = await http.post(
      //   Uri.parse('$uri/api/verify-otp'),
      //   body: jsonEncode({
      //     'email': email,
      //     'otp': otp,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );

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
        Utils.snackBarGeneralMessage(context, 'No internet connection.');
        return false;
      } else {
        // Connection error (other than no internet)
        Utils.snackBarErrorMessage(context, 'Connection error: ${e.message}');
        return false;
      }
    } on http.ClientException catch (e) {
      // Handle DioError (Dio-specific exception)
      Utils.snackBarErrorMessage(context, 'HTTP request failed: ${e.message}');
      return false;
    } catch (error) {
      // Handle network or other errors
      return false;
    }
  }

  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String mobile,
    required String otp,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        mobile: mobile,
        address: '',
        type: '',
        otp: otp,
        token: '',
        cart: [],
      );

      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8'
      };
      http.Response res = await _myRepo.signUpApi(user.toJson(), headers);

      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/signup'),
      //   body: user.toJson(),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          Utils.snackBarGeneralMessage(
            context,
            "Welcome, ${user.name}! Your home, our priority. Let's get things done!",
          );
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);

          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.bootomBar,
            (route) => false,
          );
        },
      );
    } on SocketException catch (e) {
      // Handle SocketException (connection error)
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        // No internet connection
        Utils.snackBarGeneralMessage(context, 'No internet connection.');
      } else {
        // Connection error (other than no internet)
        Utils.snackBarErrorMessage(context, 'Connection error: ${e.message}');
      }
    } on http.ClientException catch (e) {
      // Handle DioError (Dio-specific exception)
      Utils.snackBarErrorMessage(context, 'HTTP request failed: ${e.message}');
    } catch (e) {
      Utils.snackBarErrorMessage(context, e.toString());
    }
  }

  // sign in user
  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      String data = jsonEncode({
        'emailAddress': email,
        'password': password,
        "type": "c",
      });
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8'
      };
      http.Response res = await _myRepo.loginApi(data, headers);

      // http.post(
      //   Uri.parse('$uri/api/signin'),
      //   body: jsonEncode({
      //     'email': email,
      //     'password': password,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          // print(res.body);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false)
              .setUserToken(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          String? token = prefs.getString('x-auth-token');
          String data = jsonEncode({});
          Map<String, String> headers = {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization':"Bearer " + token!
          };
          http.Response userRes = await _myRepo.getUserDataApi(data, headers);
          print(userRes.body);
          Provider.of<UserProvider>(context, listen: false)
              .setUser(jsonEncode(userRes.body));
          if (prefs.getString('x-auth-token') != null &&
              prefs.getString('x-auth-token')!.isNotEmpty) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Provider.of<UserProvider>(context, listen: false)
                                .user
                                .type ==
                            'C'
                        ? const BottomBar()
                        : const AdminScreen(),
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
        Utils.snackBarErrorMessage(context, 'No internet connection.');
      } else {
        // Connection error (other than no internet)
        Utils.snackBarErrorMessage(context, 'Connection error: ${e.message}');
      }
    } on http.ClientException catch (e) {
      // Handle DioError (Dio-specific exception)
      Utils.snackBarErrorMessage(context, 'HTTP request failed: ${e.message}');
    } catch (e) {
      Utils.snackBarErrorMessage(context, 'Hello ${e.toString()}');
    }
  }

  // get user data
  Future<void> getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      String data = jsonEncode({});
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!
      };
      http.Response tokenRes = await _myRepo.getUserAPi(data, headers);

      // var tokenRes = await http.post(
      //   Uri.parse('$uri/tokenIsValid'),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //     'x-auth-token': token!
      //   },
      // );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        };
        http.Response userRes = await _myRepo.getUserDataApi(data, headers);
        // http.Response userRes = await http.get(
        //   Uri.parse('$uri/'),
        //   headers: <String, String>{
        //     'Content-Type': 'application/json; charset=UTF-8',
        //     'x-auth-token': token
        //   },
        // );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } on SocketException catch (e) {
      // Handle SocketException (connection error)
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        // No internet connection
        Utils.snackBarErrorMessage(context, 'No internet connection.');
      } else {
        // Connection error (other than no internet)
        Utils.snackBarErrorMessage(context, 'Connection error: ${e.message}');
      }
    } on http.ClientException catch (e) {
      // Handle DioError (Dio-specific exception)
      Utils.snackBarErrorMessage(context, 'HTTP request failed: ${e.message}');
    } catch (e) {
      Utils.snackBarGeneralMessage(context, e.toString());
    }
  }

  Future<void> forgotPassword({
    required BuildContext context,
    required String email,
    required String newPassword,
    required String otp,
  }) async {
    try {
      String apiData = jsonEncode({
        'email': email,
        'newPassword': newPassword,
        'otp': otp,
      });
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8'
      };
      http.Response res = await _myRepo.verifyOTP(apiData, headers);

      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/forgotpassword'),
      //   body: jsonEncode({
      //     'email': email,
      //     'newPassword': newPassword,
      //     'otp': otp,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          Utils.snackBarSuccessMessage(
              context, 'Password Successfully Changed');
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.signin,
            (route) => false,
          );
        },
      );
    } on SocketException catch (e) {
      // Handle SocketException (connection error)
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        // No internet connection
        Utils.snackBarGeneralMessage(context, 'No internet connection.');
      } else {
        // Connection error (other than no internet)
        Utils.snackBarErrorMessage(context, 'Connection error: ${e.message}');
      }
    } on http.ClientException catch (e) {
      // Handle DioError (Dio-specific exception)
      Utils.snackBarErrorMessage(context, 'HTTP request failed: ${e.message}');
    } catch (e) {
      Utils.snackBarErrorMessage(context, e.toString());
    }
  }
}
