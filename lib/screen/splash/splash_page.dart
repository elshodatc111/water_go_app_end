import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../const/color_const.dart';
import '../../screen/main_page.dart';
import '../../screen/splash/language_page.dart';
import '../widget/connected_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      var connectivityResult = await Connectivity().checkConnectivity();

      String? lang = box.read('lang');
      if (lang == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LanguagePage()),
        );
      }else if (connectivityResult == ConnectivityResult.none) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ConnectedPage()),
        );
        return;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.bgWhite,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: double.infinity,
        ),
      ),
    );
  }
}
