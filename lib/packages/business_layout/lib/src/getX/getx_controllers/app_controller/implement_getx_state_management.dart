import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_layout/data_layout.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:model/model.dart';

import 'abstract_getx_state_management.dart';

//каждый раз при изменении запускать кодогенерацию
//для запуска кодогенерации flutter packages pub run build_runner build --delete-conflicting-outputs
//чтобы зарегистрировать как фабрику для GetIt и обращаться к сервис локатору через  MainSimpleStateManagement

@Injectable(as: AbstractMainGetXStateManagement)
class MainFlutterBlocStateManagement extends AbstractMainGetXStateManagement {
  final ServicesShopping servicesShopping = GetIt.I.get<
      ServicesShopping>(); //не нужно делать для этого фабрики, (кроме Bloc) можно инициировать прям внутри

  @override
  void onInit() {
    fakeProductList.bindStream(servicesShopping.readDataFakeProductList());
    // servicesShopping
    //     .getDataListShoppingCart()
    //     .then((value) => listShoppingCartFirestore.value = value);
    listShoppingCartFirestore
        .bindStream(servicesShopping.readListShoppingCart().cast());

    super.onInit();
  }

  //добавление нового продукта в список продуктов
  ///Work with product list

  @override
  bool buildContentList = true;

  @override
  bool switchChangeTheme = Get.isDarkMode;

  ///Work with  list Shopping Cart

  @override
  RxMap<ShoppingData, int> listShoppingCartFirestore =
      <ShoppingData, int>{}.obs;

  @override
  Future<void> addToListShoppingCart(ShoppingData product) async =>
      await servicesShopping.addToListShoppingCart(
          product, listShoppingCartFirestore);

  @override
  Future<void> removeListShoppingCart(ShoppingData? product,
          {required bool allOrOneDelete}) async =>
      servicesShopping.removeListShoppingCart(
          product, listShoppingCartFirestore, allOrOneDelete);

  @override
  List listShoppingCartTotalSum() =>
      servicesShopping.listShoppingCartTotalSum(listShoppingCartFirestore);

  @override
  String listShoppingCartTotal() =>
      servicesShopping.listShoppingCartTotal(listShoppingCartFirestore);

  ///Work with product list
  ///
  @override
  final RxList<ShoppingData> fakeProductList = <ShoppingData>[].obs;

  @override
  Future<void> addToFakeProductList(ShoppingData product) async =>
      servicesShopping.addToFakeProductList(product);

  @override
  Future<void> updateFakeProductList(ShoppingData product) async =>
      servicesShopping.updateFakeProductList(product);

  @override
  Future<void> buildContentListChange() async {
    buildContentList = !buildContentList;
    update();
  }

  @override
  void changeTheme({required bool bolSwitch}) {
    switchChangeTheme = bolSwitch;
    update();
  }

  @override
  Future<Map<ShoppingData, int>> getDataListShoppingCart() => servicesShopping
      .getDataListShoppingCart()
      .then((value) => listShoppingCartFirestore.value = value);
}
