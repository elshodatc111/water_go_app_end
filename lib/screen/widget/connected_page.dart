import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_go_app_04_08_2025/screen/splash/splash_page.dart';

class ConnectedPage extends StatelessWidget {
  final VoidCallback? onRetry;

  const ConnectedPage({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final lang = box.read('lang');
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/connect.png',
                height: 200,
              ),
              const SizedBox(height: 30),
              Text(
                lang=='uz'?"Internetga ulanmagansiz!":"Вы не подключены к Интернету!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                lang=='uz'?"Iltimos, internet aloqangizni tekshiring va qaytadan urinib ko‘ring.":"Проверьте подключение к Интернету и повторите попытку.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: onRetry ?? () {
                  Get.to(()=>SplashPage());
                },
                icon: const Icon(Icons.refresh),
                label: Text(
                  lang=='uz'?"Qaytadan urinish":"Попробуйте еще раз",
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
