import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_go_app_04_08_2025/screen/main_page.dart';

class OrdersSuccessPage extends StatelessWidget {
  const OrdersSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String lang = 'uz'; // GetStorage yoki til sozlamasidan o‘qishingiz mumkin
    final mainColor = Colors.blue;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Rasm (assets ichida saqlash shart)
              SizedBox(
                height: 250,
                child: Image.asset(
                  'assets/images/success.png', // Fayl nomini moslashtiring
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              // Matn
              Text(
                lang == 'uz'
                    ? "Buyurtma qabul qilindi. Tez orada siz bilan bog'lanamiz."
                    : "Заказ принят. Скоро мы с вами свяжемся.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 40),
              // OK tugmasi
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Get.offAll(()=>MainPage()); // Or home page navigation
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
