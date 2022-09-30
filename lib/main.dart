import 'package:crud_operation_application/Controller/network_controller.dart';
import 'package:crud_operation_application/Model/Messages.dart';
import 'package:crud_operation_application/Theme/theme.dart';
import 'package:crud_operation_application/Widgets/widgetController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tale_drawer/tale_drawer.dart';

import 'Controller/crud_controller.dart';
import 'View/MyHomePage.dart';

Future<void> main() async {
  await GetStorage.init();
  final _crudControler = Get.put(CrudControler());
  final _widgetController = Get.put(WidgetController());
  //final _networkController = Get.lazyPut(() => NetworkController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Messages(),
      locale: Get.deviceLocale,
      fallbackLocale: Locale('en', 'us'),
      debugShowCheckedModeBanner: false,
      title: 'Crud Application',
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/', page: () => MyHomePage(), transition: Transition.zoom),
           
      ],
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CrudControler counter = Get.find();
  final WidgetController _widgetController = Get.find();
  //final NetworkController _networkController = Get.find();
  final type = TaleType.Zoom;

  @override
  Widget build(BuildContext context) {
    return TaleDrawer(
      sideState: SideState.RIGHT,
      controller: counter.talecontroller,
      type: type,
      body: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: appDecoration(),
          ),
          leading: IconButton(
              onPressed: () {
                
                if(counter.toDrawer.value){
                      counter.talecontroller.close();
                      counter.toDrawer.value=false;
                }
                else{
                  counter.talecontroller.open();
                  counter.toDrawer.value=true;
                }
              },
              icon: const Icon(Icons.menu)),
          title: const Text("Crud Application"),
          actions: [
            IconButton(
                onPressed: () {
                  Get.bottomSheet(
                    Container(
                      height: 120,
                      color: Get.theme.backgroundColor,
                      child: IconButton(
                          onPressed: () {
                            changeTheme();
                          },
                          icon: const  Text(''
                            // _networkController
                            //           .connectionStatus.value ==
                            //       1
                            //   ? 'Wifi Connection'
                            //   : (_networkController.connectionStatus.value == 2
                            //       ? 'Mobile Connection'
                            //       : 'No Connection')
                                  )
                                  ),
                    ),
                    enableDrag: true,
                  );
                },
                icon: const Icon(Icons.wifi,)),
            IconButton(
                onPressed: () {
                  Get.bottomSheet(
                    Container(
                      height: 120,
                      color: Get.theme.backgroundColor,
                      child: IconButton(
                          onPressed: () {
                            changeTheme();
                          },
                          icon: const Icon(Icons.change_circle)),
                    ),
                    enableDrag: true,
                  );
                },
                icon: const Icon(Icons.arrow_drop_down_sharp)),
          ],
        ),
        body: SizedBox.expand(
          child: Column(
            children: [
              Obx((() => Text(
                  "Your Incrementing value is " + counter.value.toString()))),
              const SizedBox(
                height: 200,
              ),
              Text("how are you?".tr),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        counter.changeLanguage('pk', 'ur');
                      },
                      child: const Text('Urdu')),
                  ElevatedButton(
                      onPressed: () {
                        counter.changeLanguage('hi', 'in');
                      },
                      child: const Text('Hindi'))
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
                heroTag: null,
                child: const Icon(Icons.restore),
                onPressed: () {
                  counter.restore();
                }),
            FloatingActionButton(
                heroTag: null,
                child: const Icon(Icons.add),
                onPressed: () {
                  counter.increment();
                }),
            IconButton(
                onPressed: () {
                  Get.toNamed('/MyHomePage');
                },
                icon: const Icon(Icons.arrow_forward)),
          ],
        ),
      ),
      drawer: Container(
        width: 300,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/image.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
             UserAccountsDrawerHeader(
              accountName: Text("Muhammad Javed", style: textStyleHead(),),
              accountEmail: Text("javedmughal609@gmail.com", style: textStyleHead2()),
              currentAccountPicture: const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('images/person-male.png'),
              ),
              // otherAccountsPictures: <Widget>[
              //    CircleAvatar(
              //     backgroundColor: Colors.white,
              //     child:  Text("Pilu"),
              //   ),
              // ],
            ),
            ListTile(
              title: Row(
                children: [
                  _widgetController.icon(Icons.home),
                  Text(
                    "Home",
                    style: textStyleDrawer(),
                  ),
                ],
              ),
              onTap: () => {},
            ),
            const Divider(),
            ListTile(
              title: Row(
                children: [
                  _widgetController.icon(Icons.person),
                  Text(
                    "Profile",
                    style: textStyleDrawer(),
                  ),
                ],
              ),
              onTap: () => {},
            ),
            const Divider(),
            ListTile(
              title: Row(
                children: [
                  _widgetController.icon(
                      Icons.email_outlined),
                  Text(
                    "Email Verfication",
                    style: textStyleDrawer(),
                  ),
                ],
              ),
              onTap: () => {
               
              },
            ),
            const Divider(),
            const Divider(),
            ListTile(
              title: Row(
                children: [
                  _widgetController.icon(Icons.close),
                  Text(
                    "Close",
                    style: textStyleDrawer(),
                  ),
                ],
              ),
              onTap: () => counter.talecontroller.close(),
            ),
          ],
        ),
      ),
      
    );
    
  }
}
