import 'package:business_layout/business_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model/model.dart';

import '../../widgets/model_button.dart';
import '../about_product_page/about_product_page.dart';

class CardModelView extends StatelessWidget {
  bool buildContentList; //для отображения списком или листом
  ShoppingData product;
  AbstractMainGetXStateManagement controller;
  int index;

  CardModelView({
    super.key,
    required this.index,
    required this.buildContentList,
    required this.product,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      //чтобы обрезать все элементы, которые выходят за границы
      shadowColor: Colors.black,
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => AboutProductPage(product: product));
            },
            child: Container(
              child: Image.asset(
                'assets/images/${product.photoPath}',
                fit: BoxFit.cover,
                height: buildContentList
                    ? MediaQuery.of(context).size.width / 2
                    : MediaQuery.of(context).size.width / 4,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          buildContentList
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.nameProduct!.toString(),
                        style: TextStyle(color: Colors.black),
                      ),
                      modelButton(
                        product: product,
                        index: index,
                        controller: controller,
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Column(
                            children: [
                              Expanded(
                                child: Text(
                                  product.nameProduct.toString(),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Добавлен в покупки: ${product.buy.toString()} р.',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: FittedBox(
                          child: modelButton(
                            product: product,
                            index: index,
                            controller: controller,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
      // }),
    );
  }
}

Card myCardModel(
    {required ShoppingData product,
    required bool buildContentList,
    required BuildContext context}) {
  final AbstractMainGetXStateManagement controller =
      Get.find<AbstractMainGetXStateManagement>();

  return Card(
    clipBehavior: Clip.antiAlias,
    //чтобы обрезать все элементы, которые выходят за границы
    shadowColor: Colors.black,
    elevation: 5,
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => AboutProductPage(product: product));
          },
          child: Container(
            child: Image.asset(
              'assets/images/${product.photoPath}',
              fit: BoxFit.cover,
              height: buildContentList
                  ? MediaQuery.of(context).size.width / 2
                  : MediaQuery.of(context).size.width / 4,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
        buildContentList
            ? ListTile(
                title: Text(
                  product.nameProduct!.toString(),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    controller.addToListShoppingCart(product);
                  },
                  child: GetBuilder<AbstractMainGetXStateManagement>(
                    builder: (_) =>
                        Text(product.buy! ? 'в корзинe' : 'добавить'),
                  ),
                ),
              )
            : Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: Text(
                                  product.nameProduct.toString(),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Добавлен в покупки: ${product.buy.toString()} р.',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                          onPressed: () {
                            controller.addToListShoppingCart(product);
                          },
                          child: Text('в корзину')),
                    ),
                  ],
                ),
              ),
      ],
    ),
  );
}
