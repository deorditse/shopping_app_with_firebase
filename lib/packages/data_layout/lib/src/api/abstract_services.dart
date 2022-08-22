import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:model/model.dart';

abstract class ServicesShopping {
  // void onInit();

  //добавление данных в базу
  Future<void> addToListShoppingCart(
      ShoppingData product, listShoppingCartFirestore);

  Future<void> addToFakeProductList(ShoppingData product);

  //чтение данных из базы
  Future<Map<ShoppingData, int>> getDataListShoppingCart();

  Stream<Map<ShoppingData, int>> readListShoppingCart();

  Stream<List<ShoppingData>> readDataFakeProductList();

  //обновление данных в базах
  Future<void> updateFakeProductList(ShoppingData product);

  //
  Future<void> removeListShoppingCart(
      ShoppingData? product, listShoppingCartFirestore,bool  allOrOneDelete);

  String listShoppingCartTotal(listShoppingCartFirestore);

  List listShoppingCartTotalSum(listShoppingCartFirestore);
}
