import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:water_go_app_04_08_2025/const/color_const.dart';
import 'package:water_go_app_04_08_2025/screen/auth/oferta_page.dart';

class AuthPhonePage extends StatefulWidget {
  const AuthPhonePage({super.key});

  @override
  State<AuthPhonePage> createState() => _AuthPhonePageState();
}

class _AuthPhonePageState extends State<AuthPhonePage> {
  final phoneController = TextEditingController();
  final maskFormatter = MaskTextInputFormatter(
    mask: '## ### ####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
    phoneController.addListener(_validatePhone);
  }

  void _validatePhone() {
    setState(() {
      isButtonActive = maskFormatter.getUnmaskedText().length == 9;
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final blue = Colors.blue;
    final box = GetStorage();
    final lang = box.read('lang');
    return Scaffold(
      backgroundColor: ColorConst.bgWhite,
      appBar: AppBar(
        title: Text(lang == 'uz' ? "Kirish" : "Входить"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('assets/images/phone01.png', height: 256)),
              const SizedBox(height: 30),
              Text(
                lang == 'uz'
                    ? "Telefon raqamingizni kiriting va biz ushbu raqamingizga SMS orqali tasdiqlash kodini yuboramiz."
                    : "Введите свой номер телефона, и мы отправим на этот номер проверочный код по SMS.",
                style: TextStyle(fontSize: 16, color: ColorConst.text),
              ),
              const SizedBox(height: 30),
              Text(
                lang == 'uz' ? "Telefon raqami" : "Номер телефона",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: ColorConst.text,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: blue.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(12),
                  color: blue.withOpacity(0.05),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 8,
                        top: 15,
                        bottom: 15,
                      ),
                      child: Text(
                        "+998",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: blue,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [maskFormatter],
                        decoration: InputDecoration(
                          hintText: "__ ___ ____",
                          hintStyle: TextStyle(color: blue),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 16,
                          ),
                        ),
                        style: TextStyle(color: blue),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      isButtonActive
                          ? () {
                            String fullPhone =
                                '+998${maskFormatter.getUnmaskedText()}';
                            print("Yuborilayotgan raqam: $fullPhone");
                          }
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isButtonActive ? blue : blue.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    lang == 'uz' ? "Davom etish" : "Продолжать",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  "1.11.1 (production)",
                  style: TextStyle(color: ColorConst.text, fontSize: 13),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Get.to(() => OfertaPage());
                },
                child: Text(
                  lang == 'uz'
                      ? "Davom etish orqali siz Foydalanish qoidalari va Maxfiylik siyosatiga rozilik bildirasiz."
                      : "Продолжая, вы соглашаетесь с Условиями использования и Политикой конфиденциальности.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: ColorConst.text),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
