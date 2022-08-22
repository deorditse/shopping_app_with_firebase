import 'package:business_layout/business_layout.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../widgets/appBarAction.dart';
import '../authentication/controller/auth_controller.dart';
import '../authentication/views/login_page.dart';
import 'card_product.dart';

class MyHomePage extends StatefulWidget {
  static const String id = '/';

  String? email;

  MyHomePage({super.key, this.email});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _storage = FirebaseStorage.instance;

  //инициирую контроллер с иньекцией на абстракцию
  late AbstractMainGetXStateManagement controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(GetIt.I.get<AbstractMainGetXStateManagement>());
  }

  //подключаем  storage firebase
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.approval_outlined),
        onPressed: () {
          AuthController.instance.logOut();
        },
      ),
      appBar: myCustomAppBar(),
      body: GetBuilder<AbstractMainGetXStateManagement>(
        builder: (_) {
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(children: [
                  Text(widget.email ?? ''),
                  Center(
                    child: Container(
                      height: 140,
                      child: FutureBuilder(
                        future:
                            _storage.ref('еуыефкупмип.png').getDownloadURL(),
                        builder: (context, snapshot) =>
                            snapshot.connectionState == ConnectionState.done
                                ? Image.network(
                                    snapshot.data!.toString(),
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                  )
                                : CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 38.0),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          //   Get.to(() => TestPageProductList());
                          Get.to(() => LoginView());
                        },
                        child: Text('test page'),
                      ),
                    ),
                  ),
                ]),
                Divider(),
                Expanded(
                  child: Obx(
                    () => Column(
                      children: [
                        controller.fakeProductList.isNotEmpty
                            ? controller.buildContentList
                                ? Expanded(
                                    child: ListView.builder(
                                    itemCount:
                                        controller.fakeProductList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final product =
                                          controller.fakeProductList[index];

                                      return CardModelView(
                                        buildContentList:
                                            controller.buildContentList,
                                        product: product,
                                        controller: controller,
                                        index: index,
                                      );
                                    },
                                  ))
                                : Expanded(
                                    child: GridView.builder(
                                      itemCount:
                                          controller.fakeProductList.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final product =
                                            controller.fakeProductList[index];

                                        return CardModelView(
                                          buildContentList:
                                              controller.buildContentList,
                                          product: product,
                                          controller: controller,
                                          index: index,
                                        );
                                      },
                                    ),
                                  )
                            : const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
