import 'package:firebase_clear_19/packages/model/lib/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'GetX/Controllers/controller_product.dart';

class TestPageShoppingCart extends StatelessWidget {
  static const String id = '/test_page_shopping_cart';

  // int index;
  final TestControllerGetx controller = Get.put(TestControllerGetx());

  TestPageShoppingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Тестовая PageShoppingCart'),
      ),
      body: SafeArea(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (controller.listShoppingCartFirestore.isNotEmpty)
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: controller.listShoppingCartFirestore.length,
                        itemBuilder: (context, index) {
                          return TestPageShoppingCartProductCart(
                            controller: controller,
                            product: controller.listShoppingCartFirestore.keys
                                .toList()[index],
                            quantity: controller.listShoppingCartFirestore.keys
                                .toList()[index],
                            index: index,
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text('Ваша корзина пуста'),
                        ),
                      ),
                    ),
              Divider(),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('Товаров на сумму: '),
                      Text(controller.listShoppingCartTotal().toString() ??
                          0.toString()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TestPageShoppingCartProductCart extends StatelessWidget {
  TestControllerGetx controller;
  ShoppingData product;
  dynamic quantity;
  int index;

  TestPageShoppingCartProductCart({
    required this.product,
    required this.controller,
    required this.index,
    required this.quantity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/${product.photoPath}'),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              product.nameProduct.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    controller.removeListShoppingCart(product);
                  },
                  icon: controller.listShoppingCartFirestore.values
                              .toList()[index] ==
                          1
                      ? Icon(Icons.delete)
                      : Icon(Icons.remove),
                ),
                Text(
                  product.quantity.toString(),
                ),
                IconButton(
                  onPressed: () {
                    controller.addToListShoppingCart(product);
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
