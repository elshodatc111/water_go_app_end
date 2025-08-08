import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_go_app_04_08_2025/const/color_const.dart';
import 'package:water_go_app_04_08_2025/screen/main_page.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final box = GetStorage();
    return Scaffold(
      backgroundColor: ColorConst.bgWhite,
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.7,
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: double.infinity,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Tilni tanlang / Выберите язык",
                  style: TextStyle(
                    color: ColorConst.text,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      InkWell(
                        child: Language('assets/images/uz.png', "O'zbekcha"),
                        onTap: (){
                          box.write('lang', 'uz');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const MainPage()),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        child: Language('assets/images/ru.png', "Русский"),
                        onTap: (){
                          box.write('lang', 'ru');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const MainPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40), // pastdan biroz masofa
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget Language(String image, String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(color: Colors.blue, width: 1.5),
      ),
      child: Row(
        children: [
          Image.asset(image, width: 40),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
