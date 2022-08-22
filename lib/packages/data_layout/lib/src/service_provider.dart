import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'service_provider.config.dart';

///Делаем Сервис локатор для обращения с бизнес слоя GetIt с использованием injectable чтобы делать кодогенерацию имплементаций сервиса

@InjectableInit()
Future<void> initializeServices() async => $initGetIt(GetIt.I);
//чтобы запустить кодогенерацию c injectable из текущего пакета
//flutter pub run build_runner build --delete-conflicting-outputs
