import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_go_app_04_08_2025/screen/auth/auth_phone_page.dart';
class NotTokenWidget extends StatelessWidget {
  final String lang;
  const NotTokenWidget({super.key, required this.lang});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        Image.asset('assets/images/login01.png', height: 256),
        const SizedBox(height: 32),
        lang == 'uz'
            ? Text(
          "Ilovaga kirish",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        )
            : Text(
          "Войти в приложение",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        lang == 'uz'
            ? Text(
          "Ilovaning barcha funksiyalaridan foydalanish uchun avval ilovaga kiring.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        )
            : Text(
          "Чтобы использовать все функции приложения, пожалуйста, сначала войдите в систему.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Get.to(() => AuthPhonePage(), transition: Transition.fade, duration: Duration(milliseconds: 300));
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 8),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child:
            lang == 'uz'
                ? Text(
              "Kirish",
              style: TextStyle(fontSize: 18, color: Colors.white),
            )
                : Text(
              "Входить",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
