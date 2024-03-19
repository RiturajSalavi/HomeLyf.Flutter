import 'package:homelyf_services/data/network/base_api_services.dart';
import 'package:homelyf_services/data/network/network_api_service.dart';
import 'package:homelyf_services/res/app_url.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> sendOTP(dynamic data, Map<String, String> headers) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.sendOTP, data, headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> sendOTPForgotPassword(
      dynamic data, Map<String, String> headers) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.sendOTPForgotPassword, data, headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> verifyOTP(dynamic data, Map<String, String> headers) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.verifyOTP, data, headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> signUpApi(dynamic data, Map<String, String> headers) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.signupUrl, data, headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> loginApi(dynamic data, Map<String, String> headers) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.loginUrl, data, headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getUserAPi(dynamic data, Map<String, String> headers) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.getUser, data, headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getUserDataApi(
      dynamic data, Map<String, String> headers) async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.getUserData, headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getUserOnlyDataApi(
      dynamic data, Map<String, String> headers) async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.getUserOnlyData, headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> forgotPassword(
      dynamic data, Map<String, String> headers) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.forgotPassword, data, headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
