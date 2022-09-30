import 'package:crud_operation_application/Theme/theme.dart';
import 'package:crud_operation_application/Widgets/widgetController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:crud_operation_application/Controller/crud_controller.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CrudControler _crudControler = Get.find();
  final WidgetController _widgetController = Get.find();

  @override
  Widget build(BuildContext context) {
    double width = 75;
    double height = 20;

    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: appDecoration(),
          ),
          title: const Text("Crud Application"),
          centerTitle: true,
          actions: [
            Obx(() => IconButton(
                onPressed: () {
                  if (_crudControler.toDrawer.value) {
                    _crudControler.talecontroller.close();
                  } else {
                    _crudControler.changeFormField();
                  }
                },
                icon: const Icon(Icons.new_label)))
          ],
          leading: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back)),
              Text(_crudControler.value.toString()),
            ],
          ),
        ),
        body: Obx(() => ListView(
              children: [
                //Name field and Email field for both forms
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Text(
                          _crudControler.changeForm.value ? 'Email' : 'Name'),
                    ),
                    style: const TextStyle(color: Colors.black),
                    controller: _crudControler.changeForm.value == true
                        ? _crudControler.emailController
                        : _crudControler.nameField,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                //Address Field
                _crudControler.changeForm.value == false
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text('Address'),
                          ),
                          style: const TextStyle(color: Colors.black),
                          controller: _crudControler.addressController,
                        ),
                      )
                    : const SizedBox(),

                const SizedBox(
                  height: 5,
                ),
                // Add and Update button with Different Functions
                _crudControler.changeForm.value == false
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
                        child: ElevatedButton(
                            style: buttonStyle(_crudControler.showUpdate.value
                                ? Colors.green
                                : Colors.blue),
                            onPressed: () {
                              if (_crudControler.showUpdate.value == true) {
                                _crudControler.updateData();
                                _widgetController.showSnackBar(
                                    'Congratulation',
                                    'Successfully update record',
                                    Colors.blue[200]!);
                              } else {
                                _crudControler.addData();
                                _widgetController.showSnackBar('Congratulation',
                                    'Successfully added record', Colors.green);
                              }
                            },
                            child: Text(
                              _crudControler.showUpdate.value
                                  ? "Update"
                                  : "Add",
                              style: textStyle(),
                            )),
                      )
                    : const SizedBox(),
                //Add Email Button for 2nd Form.
                _crudControler.changeForm.value == true
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (GetUtils.isEmail(
                                _crudControler.emailController.text)) {
                              _crudControler.emailStore();
                              _widgetController.showSnackBar(
                                  "Valid Email",
                                  "Successfully Store Email Address",
                                  Colors.green);
                            } else {
                              _widgetController.showSnackBar("Incorrect Email",
                                  "Provide Email in valid Format", Colors.red);
                            }
                          },
                          child: const Text('Add Email'),
                        ))
                    : const SizedBox(),
                //Read Button for 2nd Form
                _crudControler.changeForm.value == true
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
                        child: ElevatedButton(
                            onPressed: () {
                              _crudControler.readEmail();
                            },
                            child: const Text('Read Email')))
                    : const SizedBox(),

                const SizedBox(
                  height: 20,
                ),
                //ListBuilder for 1st Form
                _crudControler.changeForm.value == false
                    ? GetX<CrudControler>(builder: (_crudControler) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: _crudControler.data.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                            height: 5,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Slidable(
                              actionPane: const SlidableScrollActionPane(),
                              actionExtentRatio: 0.1,
                              actions: [
                                IconSlideAction(
                                  caption: 'Edit',
                                  color: Colors.blue,
                                  icon: Icons.edit,
                                  onTap: () {
                                    _crudControler.editData(index, context);
                                  },
                                ),
                                IconSlideAction(
                                  caption: 'delete',
                                  color: Colors.red,
                                  icon: Icons.delete,
                                  onTap: () {
                                    Get.defaultDialog(
                                      title: 'Alert!',
                                      titleStyle:
                                          const TextStyle(color: Colors.red),
                                      middleText: 'Do you want to delete',
                                      textCancel: 'Cancel',
                                      //cancelTextColor: Colors.blue,
                                      textConfirm: 'Confirm',
                                      //confirmTextColor: Colors.white,
                                      onCancel: () {
                                        Get.toNamed('/MyHomePage');
                                      },
                                      onConfirm: () {
                                        Navigator.pop(context, true);
                                        _crudControler.deleteData(index);

                                        _widgetController.showSnackBar('Oops!',
                                            'Record deleted', Colors.red);
                                      },
                                    );
                                  },
                                )
                              ],
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(7, 2, 7, 2),
                                padding: const EdgeInsets.only(bottom: 3),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                        bottomRight: Radius.circular(5),
                                        bottomLeft: Radius.circular(5)),
                                    color: Get.isDarkMode
                                        ? Colors.black
                                        : Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 4,
                                        blurRadius: 7,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ]),
                                child: ListTile(
                                  // onTap: () {
                                  //   final indexValue=_crudControler.data.indexWhere((element) => false);

                                  //   print("Index = ${indexValue}");
                                  // },
                                  // leading: const Icon(
                                  //     Icons.person), 
                                      leading: CircleAvatar(
                                    child: Text(index==0?
                                     'H':
                                    index==1? 'M': index==2? 'L' : 'E',),
                                    backgroundColor:
                                    index==0 ?
                                     Colors.green:
                                     index==1? Colors.yellow : index==2? Colors.red : Colors.blue,
                                  ),
                                  title: Text(
                                    "Your name is " +
                                        _crudControler.data[index].name,
                                  ),
                                  subtitle: Text(
                                    _crudControler.data[index].address,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      })
                    : const SizedBox(),
              ],
            )));
  }
}
