import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart'; //пакет для написания методов для  сравнения по значения а не по ссылкам виджетов

//для запуска кодогенерации flutter packages pub run build_runner build --delete-conflicting-outputs

abstract class AbstractMainGetXStateManagement extends GetxController {
  late bool switchChangeTheme;

  late bool buildContentList;

  late RxMap<ShoppingData, int> listShoppingCartFirestore;

  late RxList<ShoppingData> fakeProductList;

  void onInit();

  //добавление данных в базу
  Future<void> addToListShoppingCart(ShoppingData product);

  Future<void> addToFakeProductList(ShoppingData product);

  Future<void> updateFakeProductList(ShoppingData product);

  //
  Future<void> removeListShoppingCart(ShoppingData? product,
      {required bool allOrOneDelete});

  List listShoppingCartTotalSum();

  String listShoppingCartTotal();

  ///

  // AbstractMainGetXStateManagement();

  Future<void> buildContentListChange();

  void changeTheme({required bool bolSwitch});

  Future<Map<ShoppingData, int>> getDataListShoppingCart();
}
