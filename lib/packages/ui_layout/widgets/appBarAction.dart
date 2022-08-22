import 'package:business_layout/business_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/shopping_card/shopping_card_page.dart';

AppBar myCustomAppBar() {
  return AppBar(
    title: Text('Commerce'),
    toolbarHeight: 40,
    leading: GetBuilder<AbstractMainGetXStateManagement>(
      builder: (controller) => IconButton(
        onPressed: () {
          controller.buildContentListChange();
        },
        icon: controller.buildContentList
            ? Icon(Icons.grid_view)
            : Icon(Icons.list),
      ),
    ),
    actions: [
      appBarAction(),
    ],
  );
}

Row appBarAction() {
  final AbstractMainGetXStateManagement controller =
      Get.find<AbstractMainGetXStateManagement>();

  return Row(
    children: [
      GetBuilder<AbstractMainGetXStateManagement>(
        builder: (controller) => Switch(
          value: controller.switchChangeTheme,
          //чтобы отслеживать системную тему
          onChanged: (bolVal) {
            controller.changeTheme(bolSwitch: bolVal);
            Get.changeThemeMode(
              bolVal ? ThemeMode.dark : ThemeMode.light,
            );
          },
        ),
      ),
      TextButton(
        onPressed: () {
          Get.to(() => ShoppingCard());
        },
        child: Row(
          children: [
            Text('товаров'),
            SizedBox(
              width: 5,
            ),
            Obx(
              () => Text(
                controller.listShoppingCartFirestore.length.toString(),
              ),
            ),
            Icon(Icons.account_balance_wallet),
          ],
        ),
      ),
    ],
  );
}
