import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UiUtils {
  static void showErrorAlert({
    String title = "Something went wrong",
    required String message,
    int duration = 7,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.pinkAccent,
      colorText: Colors.white,
      duration: Duration(seconds: duration),
    );
  }
}
