// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:homelyf_services/utils/error_handling.dart';
import 'package:homelyf_services/utils/global_variables.dart';
import 'package:homelyf_services/utils/utils.dart';
import 'package:homelyf_services/view/admin/models/sales.dart';
import 'package:homelyf_services/models/order.dart';
import 'package:homelyf_services/models/product.dart';
import 'package:homelyf_services/view_model/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    name = name.trim();
    description = description.trim();
    category = category.trim();
    try {
      final cloudinary = CloudinaryPublic('denfgaxvg', 'uszbstnu');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          Utils.snackBarSuccessMessage(context, 'Product Added Successfully!');
          Navigator.pop(context);
        },
      );
    } on DioException catch (e) {
      // Log the error for debugging
      print('DioError occurred: $e');

      // Handle DioError
      if (e.response != null) {
        // DioError with response
        Utils.snackBarErrorMessage(context,
            'Error: ${e.response?.statusCode} - ${e.response?.statusMessage}');
      } else {
        // DioError without response
        Utils.snackBarGeneralMessage(
            context, 'Network error. Please check your internet connection.');
      }
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

  // get all the products
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      // http.Response res =
      //     await http.get(Uri.parse('$uri/admin/get-products'), headers: {
      //   'Content-Type': 'application/json; charset=UTF-8',
      //   'x-auth-token': userProvider.user.token,
      // });

      // httpErrorHandle(
      //   response: res,
      //   context: context,
      //   onSuccess: () {
      //     for (int i = 0; i < jsonDecode(res.body).length; i++) {
      //       productList.add(
      //         Product.fromJson(
      //           jsonEncode(
      //             jsonDecode(res.body)[i],
      //           ),
      //         ),
      //       );
      //     }
      //   },
      // );
    } catch (e) {
      Utils.snackBarErrorMessage(context, e.toString());
    }
    return productList;
  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      Utils.snackBarErrorMessage(context, e.toString());
    }
  }

  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-orders'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      Utils.snackBarErrorMessage(context, e.toString());
    }
    return orderList;
  }

  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': order.id,
          'status': status,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e) {
      Utils.snackBarErrorMessage(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarning = 0;
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/analytics'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var response = jsonDecode(res.body);
          totalEarning = response['totalEarnings'];
          sales = [
            Sales('Cleaning', response['cleaningEarnings']),
            Sales('Plumbing', response['plumbingEarnings']),
            Sales('Electrician', response['electricianEarnings']),
            Sales('Gardening', response['gardeningEarnings']),
            Sales('Carpentry', response['carpentryEarnings']),
          ];
        },
      );
    } catch (e) {
      Utils.snackBarErrorMessage(context, e.toString());
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }
}
