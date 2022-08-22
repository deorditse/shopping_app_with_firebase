import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../business_layout.dart';

class BasicsExampleBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<AbstractMainGetXStateManagement>(
    //     () => );
    Get.put(GetIt.I.get<AbstractMainGetXStateManagement>());
  }
}
