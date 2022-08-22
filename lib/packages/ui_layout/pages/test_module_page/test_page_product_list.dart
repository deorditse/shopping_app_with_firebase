import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_clear_19/packages/model/lib/model.dart';
import 'package:firebase_clear_19/packages/ui_layout/pages/test_module_page/test_page_shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'GetX/Controllers/controller_product.dart';
import 'model_button.dart';

class TestPageProductList extends StatefulWidget {
  static const String id = '/test_page_product_list';

  TestPageProductList({Key? key}) : super(key: key);

  @override
  State<TestPageProductList> createState() => _TestPageProductListState();
}

class _TestPageProductListState extends State<TestPageProductList> {
  late TestControllerGetx controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put<TestControllerGetx>(TestControllerGetx());
    controller.getDataListShoppingCart();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Тестовая PageProductList'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => TestPageShoppingCart());
                },
                child: Text('перейти к корзине'),
              ),
            ),
            Expanded(
              child: Obx(
                () => Column(
                  children: [
                    controller.fakeProductList.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: controller.fakeProductList.length,
                              itemBuilder: (context, index) {
                                final product =
                                    controller.fakeProductList[index];
                                return Card(
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/${product.photoPath}',
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 100,
                                      ),
                                      Obx(
                                        () => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(product.nameProduct
                                                  .toString()),
                                              controller
                                                      .listShoppingCartFirestore
                                                      .containsKey(product)

                                                  // controller
                                                  //     .listShoppingCartFirestore
                                                  //     .keys.toList().map((e) =>
                                                  // e.uid ==
                                                  // product.uid ? true : false).toList()
                                                  ? ElevatedButton(
                                                      autofocus: true,
                                                      onPressed: () {
                                                        // controller
                                                        //     .addToListShoppingCart(
                                                        //         product);
                                                      },
                                                      child: Text('добавлен')

                                                      // modelButton(
                                                      //     product: product,
                                                      //     index: index,
                                                      //     controller:
                                                      //         controller),
                                                      )
                                                  : ElevatedButton(
                                                      onPressed: () {
                                                        controller
                                                            .addToListShoppingCart(
                                                                product);
                                                      },
                                                      child: Text('в корзину'),
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
      ),
    );
  }
}
