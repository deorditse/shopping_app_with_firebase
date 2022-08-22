import 'package:business_layout/business_layout.dart';
import 'package:firebase_clear_19/packages/ui_layout/pages/about_product_page/about_product_page.dart';
import 'package:firebase_clear_19/packages/ui_layout/pages/authentication/controller/bindings.dart';
import 'package:firebase_clear_19/packages/ui_layout/pages/authentication/views/login_page.dart';
import 'package:firebase_clear_19/packages/ui_layout/pages/home_page/home_page.dart';
import 'package:firebase_clear_19/packages/ui_layout/pages/shopping_card/shopping_card_page.dart';
import 'package:firebase_clear_19/packages/ui_layout/pages/test_module_page/GetX/bindings.dart';
import 'package:firebase_clear_19/packages/ui_layout/pages/test_module_page/test_page_product_list.dart';
import 'package:firebase_clear_19/packages/ui_layout/pages/test_module_page/test_page_shopping_cart.dart';
import 'package:firebase_clear_19/packages/ui_layout/theme_app/custom_theme/material_theme/custom_theme_material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyGetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // initialBinding: BasicsExampleBinding(),
      theme: themeLight,
      darkTheme: themeDark,
      themeMode: ThemeMode.system,
      initialRoute: MyHomePage.id,
      getPages: [
        GetPage(
          name: LoginView.id,
          page: () => LoginView(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: MyHomePage.id,
          page: () => MyHomePage(),
          binding: BasicsExampleBinding(),
        ),
        GetPage(
          name: AboutProductPage.id,
          page: () => AboutProductPage.init(),
          binding: BasicsExampleBinding(),
        ),
        GetPage(
          name: ShoppingCard.id,
          page: () => ShoppingCard(),
          binding: BasicsExampleBinding(),
        ),

        ///with page for testing
        GetPage(
          name: TestPageProductList.id,
          page: () => TestPageProductList(),
          binding: TestGetXBinding(),
        ),
        GetPage(
          name: TestPageShoppingCart.id,
          page: () => TestPageShoppingCart(),
          binding: TestGetXBinding(),
        ),
      ],
    );
  }
}
