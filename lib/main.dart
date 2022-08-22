import 'package:business_layout/business_layout.dart';
import 'package:firebase_clear_19/packages/ui_layout/pages/authentication/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'packages/ui_layout/myApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthController())); //для авторизации пользователя

  await initializeBlocs();
  runApp(MyGetApp());
}
