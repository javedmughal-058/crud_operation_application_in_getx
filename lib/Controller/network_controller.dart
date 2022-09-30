import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  var connectionStatus = 0.obs;
  final Connectivity _connectivity = Connectivity();
  //StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   // initConnectivity();
    //_connectivitySubscription =_connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  // Future<void> initConnectivity() async {
  //   ConnectivityResult result;
  //   try {
  //       result= await _connectivity.checkConnectivity();



  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  //  // return _updateConnectionStatus(result);
  // }

  _updateConnectionStatus(ConnectivityResult result){
    switch(result){
      case ConnectivityResult.wifi:
      connectionStatus.value=1;
      break;

      case ConnectivityResult.mobile:
      connectionStatus.value=1;
      break;

      case ConnectivityResult.none:
      connectionStatus.value=0;
      break;
      default:
      Get.snackbar('Network Error', 'Failed to get network Connection');

    }
  }
}
