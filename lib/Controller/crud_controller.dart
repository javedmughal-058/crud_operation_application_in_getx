// ignore: file_names
import 'dart:developer';
import 'dart:math';

import 'package:crud_operation_application/Model/employee.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tale_drawer/tale_drawer.dart';

class CrudControler extends GetxController {
  late TextEditingController nameField;
  late TextEditingController addressController;
  var talecontroller = TaleController();
  late TextEditingController emailController;


  var data = <Employee>[].obs;
  var value = 0.obs;
  var showUpdate = false.obs;
  int indexOfList = 0;
  var storage = GetStorage();
  var changeForm = false.obs;
  var toDrawer = false.obs;

  
  

  @override
  void onInit() {
    super.onInit();
    nameField = TextEditingController();
    addressController = TextEditingController();
    talecontroller = TaleController();
    emailController = TextEditingController();

  }

  @override
  void dispose() {
    nameField.dispose();
    addressController.dispose();

    super.dispose();
  }

  void changeFormField() {
    changeForm.value = !changeForm.value;
  }

  void emailStore() {
    storage.write('email', emailController.text);
    emailController.clear();
  }

  void readEmail() {
    if (storage.isNull) {
      Get.snackbar('Storage', 'No Email found');
    } else {
      Get.defaultDialog(
        title: 'Storage Email',
        middleText: 'The Email is ' + storage.read('email'),
      );
    }
  }

  void changeLanguage(var v1, var v2) {
    var locale = Locale(v1, v2);
    Get.updateLocale(locale);
  }

  void addData() {
    Employee emp = Employee(addressController.text, nameField.text);
    data.add(emp);

    nameField.clear();
    addressController.clear();
    
  }

  editData(
    int index,
    context,
  ) {
    nameField.text = data[index].name;
    addressController.text = data[index].address;

    indexOfList = index;
    showUpdate.value = true;
  }

  updateData() {
    Employee emp = Employee(addressController.text, nameField.text);
    data[indexOfList] = emp;
    nameField.clear();
    addressController.clear();
    showUpdate.value = false;
  }

  deleteData(int index) {
    data.remove(data[index]);
    nameField.clear();
    addressController.clear();
    showUpdate.value = false;
  }

  increment() {
    value++;
  }

  restore() {
    value.value = 0;
  }
  
}
