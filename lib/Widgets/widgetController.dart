import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetController extends GetxController{



  showSnackBar(String title, String middleText, Color backgroundCOlor) {
    Get.snackbar(
      title,
      middleText,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      backgroundColor: backgroundCOlor,
      borderColor: Colors.black,
      borderWidth: 1,
      animationDuration: const Duration(seconds: 1),
      margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
      overlayBlur: 1,
    );
  
  }




  Icon icon(IconData _icon){
    return Icon(
      _icon,
      color: Colors.white,
      size: 16,

    );
  } 
}