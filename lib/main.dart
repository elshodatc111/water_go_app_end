import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_go_app_04_08_2025/const/color_const.dart';
import 'package:water_go_app_04_08_2025/screen/splash/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'WaterGo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: AppBarTheme(
          backgroundColor: ColorConst.bg,
          centerTitle: true,
          titleTextStyle: TextStyle(color: ColorConst.bgWhite,fontWeight: FontWeight.w700,fontSize: 20),
          iconTheme: IconThemeData(color: ColorConst.bgWhite, size: 20),
        ),
        scaffoldBackgroundColor: ColorConst.bgWhite,
      ),
      home: SplashPage(),
    );
  }
}
