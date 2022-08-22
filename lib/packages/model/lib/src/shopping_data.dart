// import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
// part 'shopping_data.freezed.dart';

part 'shopping_data.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
//реализация c использванием пакета freezed чтобы не переопределять методы вручную, чтобы класы сравнивались не по ссылкам, а по значениям
//для запуска кодогенерации в текущем пакете flutter pub run build_runner build --delete-conflicting-outputs
//реализация c использванием пакета freezed чтобы не переопределять методы вручную, чтобы класы сравнивались не по ссылкам, а по значениям #для переопределения методов toString copyWith

@JsonSerializable(explicitToJson: true)
//explicitToJson - чтобы получать конвертацию в json а не Instance класса
class ShoppingData {
  String? uid = 'нет данных';
  bool? buy = false;
  num? price = 0;
  String? nameProduct = 'нет данных';
  String? photoPath = 'нет данных';
  int? quantity = 0;

  ShoppingData({
    required this.quantity,
    required this.price,
    required this.uid,
    required this.buy,
    required this.nameProduct,
    required this.photoPath,
  });

  factory ShoppingData.fromJson(Map<String, dynamic> json) =>
      _$ShoppingDataFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingDataToJson(this);
}
//
//
// @freezed //сразу предоставляет доступ и к toJson
// @JsonSerializable(explicitToJson: true)
// //explicitToJson - чтобы получать конвертацию в json а не Instance класса
// class ShoppingData with _$ShoppingData {
//   const factory ShoppingData({
//     required String? uid,
//     required bool? buy,
//     required String? nameProduct,
//     required String? photoPath,
//   }) = _MyShoppingData;
//
//   factory ShoppingData.fromJson(Map<String, Object?> json) =>
//       _$ShoppingDataFromJson(json);
// }
//
// // import 'package:json_annotation/json_annotation.dart';
// //
// // part 'products/products_list.g.dart';
// //
// // //flutter pub run build_runner build --delete-conflicting-outputs
// //
// // @JsonSerializable(explicitToJson: true)
// // //explicitToJson - чтобы получать конвертацию в json а не Instance класса
// // class ProductList {
// //   String nameProduct;
// //   bool buy;
// //
// //   ProductList({required this.nameProduct, required this.buy});
// //
// //   factory ProductList.fromJson(Map<String, dynamic> json) =>
// //       _$ProductListFromJson(json);
// //
// //   Map<String, dynamic> toJson() => _$ProductListToJson(this);
// // }
