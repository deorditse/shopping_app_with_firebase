import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/lib/model.dart';
import 'GetX/Controllers/controller_product.dart';

modelButton({
  required ShoppingData product,
  required int index,
  required TestControllerGetx controller,
}) {
  return Obx(
    () => Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            controller.removeListShoppingCart(product);
          },
          icon: controller.listShoppingCartFirestore.values.toList()[index] == 1
              ? Icon(Icons.delete)
              : Icon(Icons.remove),
        ),
        Text(
          controller.listShoppingCartFirestore.values
              .toList()[index - 1]
              .toString(),
        ),
        IconButton(
          onPressed: () {
            controller.addToListShoppingCart(product);
          },
          icon: Icon(Icons.add),
        ),
      ],
    ),
  );
}
