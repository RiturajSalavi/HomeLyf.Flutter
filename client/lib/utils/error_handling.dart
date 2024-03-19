import 'dart:convert';

import 'package:homelyf_services/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 201:
      onSuccess();
      break;
    case 400:
      Utils.snackBarErrorMessage(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      Utils.snackBarErrorMessage(context, jsonDecode(response.body)['error']);
      break;
    default:
      Utils.snackBarErrorMessage(context, response.body);
  }
}
