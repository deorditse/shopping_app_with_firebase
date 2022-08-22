import 'package:business_layout/business_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model/model.dart';
import '../../widgets/appBarAction.dart';
import '../../widgets/model_button.dart';

class AboutProductPage extends StatelessWidget {
  static const String id = '/aboutProduct';

  ShoppingData? product;

  AboutProductPage({required this.product});

  AboutProductPage.init();

  final controller = Get.find<AbstractMainGetXStateManagement>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commerce'),
        actions: [
          appBarAction(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/${product!.photoPath}'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    product!.nameProduct.toString(),
                  ),
                  modelButton(
                    product: product,
                    index: controller.fakeProductList.indexOf(product),
                    controller: controller,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
