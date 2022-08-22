// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingData _$ShoppingDataFromJson(Map<String, dynamic> json) => ShoppingData(
      quantity: json['quantity'] as int?,
      price: json['price'] as num?,
      uid: json['uid'] as String?,
      buy: json['buy'] as bool?,
      nameProduct: json['nameProduct'] as String?,
      photoPath: json['photoPath'] as String?,
    );

Map<String, dynamic> _$ShoppingDataToJson(ShoppingData instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'buy': instance.buy,
      'price': instance.price,
      'nameProduct': instance.nameProduct,
      'photoPath': instance.photoPath,
      'quantity': instance.quantity,
    };
