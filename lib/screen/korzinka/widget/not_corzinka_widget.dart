import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class NotCorzinkaWidget extends StatelessWidget {
  const NotCorzinkaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final lang = box.read('lang') ?? 'uz';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/empte.png', height: 180),
          const SizedBox(height: 24),
          Text(
            lang=='uz'?"Savat hozircha bo'sh":"Корзина в данный момент пуста.",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            lang=='uz'?"Asosiy sahifadan boshlang - kerakli tovar to'plamlarini ko'rishingiz mumkin.":"Начните с главной страницы - вы можете увидеть необходимые вам наборы продуктов.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
