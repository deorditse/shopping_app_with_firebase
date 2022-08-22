import 'package:firebase_clear_19/packages/business_layout/lib/business_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/lib/model.dart';

modelButton({
  required product,
  required index,
  required controller,
}) {
  return Obx(
    () => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        controller.listShoppingCartFirestore.isNotEmpty &&
                index < controller.listShoppingCartFirestore.values.length
            ? Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.removeListShoppingCart(product,
                          allOrOneDelete: false);
                    },
                    icon: controller.listShoppingCartFirestore.values
                                .toList()[index] ==
                            1
                        ? Icon(Icons.delete)
                        : Icon(Icons.remove),
                  ),
                  Obx(
                    () => Text(controller.listShoppingCartFirestore.values
                        .toList()[index]
                        .toString()),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.addToListShoppingCart(product);
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              )
            : ElevatedButton(
                onPressed: () {
                  controller.addToListShoppingCart(product);
                },
                child: Text('В корзину'),
              ),
      ],
    ),
  );
}
