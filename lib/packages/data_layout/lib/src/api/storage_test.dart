import 'package:model/model.dart';

List<int> fakeArticle = List<int>.generate(
    8, (index) => (11123 + index * 5)); //прото для различия товаров

class ProductListRepository {
  static List<ShoppingData> allProducts = <ShoppingData>[
    ShoppingData(
      quantity: 0,
      price: 23534,
      uid: '000000000001',
      buy: false,
      nameProduct: 'Товар c названием ${fakeArticle[0]}',
      photoPath: '6338632081.jpg',
    ),
    ShoppingData(
      quantity: 0,
      price: 2344,
      uid: '000000000002',
      buy: false,
      nameProduct: 'Товар c названием ${fakeArticle[1]}',
      photoPath: '6270136662.jpg',
    ),
    ShoppingData(
      quantity: 0,
      price: 6534,
      uid: '000000000003',
      buy: false,
      nameProduct: 'Товар c названием ${fakeArticle[2]}',
      photoPath: '6277697472.jpg',
    ),
    ShoppingData(
      quantity: 0,
      price: 2345,
      uid: '000000000004',
      buy: false,
      nameProduct: 'Товар c названием ${fakeArticle[3]}',
      photoPath: '6324761003.jpg',
    ),
    ShoppingData(
      quantity: 0,
      price: 23423,
      uid: '000000000005',
      buy: false,
      nameProduct: 'Товар c названием ${fakeArticle[4]}',
      photoPath: '6335734669.jpg',
    ),
    ShoppingData(
      quantity: 0,
      price: 245,
      uid: '000000000006',
      buy: false,
      nameProduct: 'Товар c названием ${fakeArticle[5]}',
      photoPath: '6338632081.jpg',
    ),
    ShoppingData(
      quantity: 0,
      price: 345,
      uid: '000000000007',
      buy: false,
      nameProduct: 'Товар c названием ${fakeArticle[0]}',
      photoPath: '6338665205.jpg',
    ),
    ShoppingData(
      quantity: 0,
      price: 545,
      uid: '000000000008',
      buy: false,
      nameProduct: 'Товар c названием ${fakeArticle[0]}',
      photoPath: '6338632081.jpg',
    ),
  ];

  static Future<List<ShoppingData>> loadFakeAllProduct() async {
    return allProducts;
  }

  static Future<void> saveAllProduct(ShoppingData product) async {
    //Here should be saving item to repository
    return;
  }
}
