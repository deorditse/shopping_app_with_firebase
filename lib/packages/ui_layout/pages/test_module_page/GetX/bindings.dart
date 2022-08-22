import 'package:get/get.dart';
import 'Controllers/controller_product.dart';

class TestGetXBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<TestControllerGetx>(TestControllerGetx());
  }
}
