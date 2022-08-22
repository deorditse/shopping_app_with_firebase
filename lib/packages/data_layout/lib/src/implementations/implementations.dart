import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:model/model.dart';

import '../../data_layout.dart';
import '../api/storage_test.dart';

//каждый раз при изменении запускать кодогенерацию
//для запуска кодогенерации flutter packages pub run build_runner build --delete-conflicting-outputs
//чтобы зарегистрировать как фабрику для GetIt и обращаться к сервис локатору через  MainSimpleStateManagement
//при использовании пакета freezed будет реализовано
//регистрируем как LazySingleton (одиночный) но вытаскиваем по запросу ShoppingData
@LazySingleton(as: ServicesShopping)
class ImplemetShoppingCardServices implements ServicesShopping {
  // @override
  // void onInit() {
  //   fakeProductList.bindStream(readDataFakeProductList());
  //   // listShoppingCartFirestore.bindStream(readListShoppingCart());
  //   getDataListShoppingCart();
  //   super.onInit();
  // }

  ///Work with  list Shopping Cart
  @override
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
      return result;
    });
  }

  ///если нужен стрим
  @override
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

      print('____________result___${result.values.toList()}');
      return result;
    });
  }

  @override
  Future<void> addToListShoppingCart(
      ShoppingData product, listShoppingCartFirestore) async {
    final docProduct = FirebaseFirestore.instance
        .collection('listShoppingCart')
        .doc(product.uid.toString());

    product.buy = true;
    if (listShoppingCartFirestore.containsKey(product)) {
      listShoppingCartFirestore[product] =
          listShoppingCartFirestore[product]! + 1;
      product.quantity = listShoppingCartFirestore[product];
      await docProduct.delete();
      await docProduct.update({product.quantity.toString(): product.toJson()});
    } else {
      listShoppingCartFirestore[product] = 1;
      product.quantity = 1;
      await docProduct.set({'1': product.toJson()});
    }
    // getDataListShoppingCart();
    // listShoppingCartFirestore.bindStream(readListShoppingCart());
    Get.snackbar(
      'Продукт добавлен в корзину',
      'Вы добавили ${product.nameProduct}',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  @override
  Future<void> removeListShoppingCart(ShoppingData? product,
      listShoppingCartFirestore, bool allOrOneDelete) async {
    if (allOrOneDelete) {
      FirebaseFirestore.instance.collection('listShoppingCart').doc().delete();

      Get.snackbar(
        'Все элементы корзины удалены',
        '',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    } else {
      final docProduct = FirebaseFirestore.instance
          .collection('listShoppingCart')
          .doc(product!.uid.toString());

      if (listShoppingCartFirestore.containsKey(product) &&
          product.quantity! == 1) {
        listShoppingCartFirestore.remove(product);
        await docProduct.delete();
      } else {
        listShoppingCartFirestore[product] =
            listShoppingCartFirestore[product]! - 1;
        product.quantity = listShoppingCartFirestore[product];
        await docProduct.set({product.quantity.toString(): product.toJson()});

        Get.snackbar(
          'Продукт удален из корзины',
          'Вы удалили ${product.nameProduct}',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
      }
      // getDataListShoppingCart();
      // listShoppingCartFirestore.bindStream(readListShoppingCart());

    }
  }

  ///Work with product list
  final fakeProductList = <ShoppingData>[].obs;

  @override
  Future<void> addToFakeProductList(ShoppingData product) async {
    final docProduct =
        FirebaseFirestore.instance.collection('fakeProductList').doc();
    product.uid = docProduct.id;
    await docProduct.set(product.toJson());
  }

  @override
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

  @override
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

  @override
  List listShoppingCartTotalSum(listShoppingCartFirestore) =>
      listShoppingCartFirestore.entries
          .map((product) => product.key.price! * product.value)
          .toList();

  @override
  String listShoppingCartTotal(listShoppingCartFirestore) =>
      listShoppingCartFirestore.isNotEmpty
          ? listShoppingCartFirestore.entries
              .map((product) => product.key.price! * product.value)
              .toList()
              .reduce((value, element) => value + element)
              .toStringAsFixed(2)
          : 'пусто';
}
