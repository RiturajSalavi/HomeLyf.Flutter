import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Utils {
  static void fieldFocusChange(
    BuildContext context,
    FocusNode current,
    FocusNode nextFocus,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  // static toastMessage(String message) {
  //   Fluttertoast.showToast(
  //     msg: message,
  //     backgroundColor: Colors.black,
  //     textColor: Colors.white,
  //     timeInSecForIosWeb: 3,
  //   );
  // }

  // static flushBarErrorMessage(String message, BuildContext context) {
  //   showFlushbar(
  //     context: context,
  //     flushbar: Flushbar(
  //       forwardAnimationCurve: Curves.decelerate,
  //       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //       padding: const EdgeInsets.all(15),
  //       message: message,
  //       duration: const Duration(seconds: 3),
  //       flushbarPosition: FlushbarPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       reverseAnimationCurve: Curves.easeInOut,
  //       borderRadius: BorderRadius.circular(10),
  //       positionOffset: 20,
  //       icon: const Icon(
  //         Icons.error,
  //         size: 28,
  //         color: Colors.white,
  //       ),
  //     )..show(context),
  //   );
  // }

  static snackBarErrorMessage(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 25,
              color: Colors.white,
            ),
            const SizedBox(width: 8), // Adjust spacing as needed
            Expanded(
              child: Text(
                message,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                overflow: TextOverflow
                    .visible, // Allow text to overflow instead of being clipped
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Set your desired border radius here
        ),
      ),
    );
  }

  static snackBarSuccessMessage(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_outline_rounded,
              size: 25,
              color: Colors.white,
            ),
            const SizedBox(width: 8), // Adjust spacing as needed
            Expanded(
              child: Text(
                message,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                overflow: TextOverflow
                    .visible, // Allow text to overflow instead of being clipped
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Set your desired border radius here
        ),
      ),
    );
  }

  static snackBarGeneralMessage(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.adjust_rounded,
              size: 25,
              color: Colors.white,
            ),
            const SizedBox(width: 8), // Adjust spacing as needed
            Expanded(
              child: Text(
                message,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                overflow: TextOverflow
                    .visible, // Allow text to overflow instead of being clipped
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Set your desired border radius here
        ),
        animation: CurvedAnimation(
          parent: const AlwaysStoppedAnimation(1),
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      content: Text(text),
    ),
  );
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
