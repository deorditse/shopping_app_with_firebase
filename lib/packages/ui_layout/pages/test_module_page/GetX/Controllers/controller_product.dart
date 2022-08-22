import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../model/lib/model.dart';

class TestControllerGetx extends GetxController {
  @override
  void onInit() {
    fakeProductList.bindStream(readDataFakeProductList());
    // listShoppingCartFirestore.bindStream(readListShoppingCart());
    getDataListShoppingCart();
    super.onInit();
  }

  ///Work with  list Shopping Cart
  RxMap<ShoppingData, int> listShoppingCartFirestore =
      <ShoppingData, int>{}.obs;

  //
  Future<Map<ShoppingData, int>> getDataListShoppingCart() async {
    Map<ShoppingData, int> result = {};
    return await FirebaseFirestore.instance
        .collection('listShoppingCart')
        .get()
        .then((value) {
      value.docs.map(
        (docSnapshot) {
          if (docSnapshot.data() != null) {
            docSnapshot.data().forEach((key, value) {
              ShoppingData data = ShoppingData.fromJson(value);
              print('____________data___${data}');
              print('____________key___${key}');
              result[data] = int.parse(key);
            });
          }
        },
      ).toList();
      listShoppingCartFirestore.value = result;
      return result;
    });
  }

  ///если нужен стрим
  Stream<Map<ShoppingData, int>> readListShoppingCart() {
    Map<ShoppingData, int> result = {};
    return FirebaseFirestore.instance
        .collection('listShoppingCart')
        .snapshots()
        .map((snapshot) {
      snapshot.docs.map(
        (doc) {
          doc.data().forEach(
            (key, value) {
              ShoppingData data = ShoppingData.fromJson(value);
              print('____________data___${data}');
              print('____________key___${key}');
              result[data] = int.parse(key);
            },
          );
        },
      ).toList();
      return result;
    });
  }

  Future<void> addToListShoppingCart(ShoppingData product) async {
    final docProduct = FirebaseFirestore.instance
        .collection('listShoppingCart')
        .doc(product.uid.toString());

    product.buy = true;
    if (listShoppingCartFirestore.containsKey(product)) {
      listShoppingCartFirestore[product] =
          listShoppingCartFirestore[product]! + 1;
      product.quantity = listShoppingCartFirestore[product]!;
      await docProduct.set({product.quantity.toString(): product.toJson()});
    } else {
      listShoppingCartFirestore[product] = 1;
      product.quantity = 1;
      await docProduct.set({'1': product.toJson()});
      print(
          '_____________________${listShoppingCartFirestore[product].runtimeType}');
    }
    getDataListShoppingCart();
    // listShoppingCartFirestore.bindStream(readListShoppingCart());
    Get.snackbar(
      'Продукт добавлен в корзину',
      'Вы добавили ${product.nameProduct}',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  Future<void> removeListShoppingCart(ShoppingData product) async {
    final docProduct = FirebaseFirestore.instance
        .collection('listShoppingCart')
        .doc(product.uid.toString());

    if (listShoppingCartFirestore.containsKey(product) &&
        product.quantity == 1) {
      listShoppingCartFirestore.remove(product);
      await docProduct.delete();
    } else {
      listShoppingCartFirestore[product] =
          listShoppingCartFirestore[product]! - 1;
      product.quantity = listShoppingCartFirestore[product]!;
      await docProduct.set({product.quantity.toString(): product.toJson()});
    }
    getDataListShoppingCart();

    // getData().then((value) => listShoppingCartFirestore.value = value);
    // listShoppingCartFirestore.bindStream(readListShoppingCart());
    Get.snackbar(
      'Продукт удален из корзины',
      'Вы удалили ${product.nameProduct}',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  List listShoppingCartTotalSum() => listShoppingCartFirestore.entries
      .map((product) => product.key.price! * product.value)
      .toList();

  String listShoppingCartTotal() => listShoppingCartFirestore.isNotEmpty
      ? listShoppingCartFirestore.entries
          .map((product) => product.key.price! * product.value)
          .toList()
          .reduce((value, element) => value + element)
          .toStringAsFixed(2)
      : 'пусто';

  ///Work with product list
  final fakeProductList = <ShoppingData>[].obs;

  Future<void> addToFakeProductList(ShoppingData product) async {
    final docProduct =
        FirebaseFirestore.instance.collection('fakeProductList').doc();
    product.uid = docProduct.id;
    await docProduct.set(product.toJson());
  }

  Future<void> updateFakeProductList(ShoppingData product) async {
    final docProduct = FirebaseFirestore.instance
        .collection('fakeProductList')
        .doc(product.uid);
    // final json = ShoppingData(
    //     uid: docProduct.id,
    //     buy: product.buy,
    //     nameProduct: product.nameProduct,
    //     photoPath: product.photoPath)
    //     .toJson();
    docProduct.update(product.toJson());
  }

  Stream<List<ShoppingData>> readDataFakeProductList() {
    return FirebaseFirestore.instance
        .collection('fakeProductList')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ShoppingData.fromJson(doc.data()))
              .toList(),
        );
  }
}
