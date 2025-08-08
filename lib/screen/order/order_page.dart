import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_go_app_04_08_2025/screen/auth/auth_phone_page.dart';
import 'package:water_go_app_04_08_2025/screen/widget/not_token_widget.dart';
class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');
    final lang = box.read('lang');
    return Scaffold(
      appBar: AppBar(
        title: box.read('lang')=='uz'?Text("Buyurtmalar"):Text("Заказы"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: token == null ? NotTokenWidget(lang: lang) : Order(lang),
      ),
    );
  }
  Widget Order(String lang){
    return Text("Orders");
  }

}
