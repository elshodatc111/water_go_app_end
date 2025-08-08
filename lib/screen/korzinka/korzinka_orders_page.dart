import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_go_app_04_08_2025/screen/korzinka/maps_page.dart';

class KorzinkaOrdersPage extends StatefulWidget {
  final List<Map<String, dynamic>> orderData;
  final int totalSum;
  final int totalQuantity;

  const KorzinkaOrdersPage({
    super.key,
    required this.orderData,
    required this.totalSum,
    required this.totalQuantity,
  });

  @override
  State<KorzinkaOrdersPage> createState() => _KorzinkaOrdersPageState();
}

class _KorzinkaOrdersPageState extends State<KorzinkaOrdersPage> {
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String lang = box.read('lang') ?? 'uz';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          lang == 'uz' ? "Buyurtmani tasdiqlash" : "Подтверждение заказа",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            _buildInfoItem(
              icon: Icons.inventory_2_rounded,
              title: lang == 'uz' ? "Mahsulot soni:" : "Номер продукта",
              value: '${widget.totalQuantity}',
            ),
            _divider(),
            _buildInfoItem(
              icon: Icons.attach_money_rounded,
              title: lang == 'uz' ? "Mahsulot narxi:" : "Цена продукта",
              value: '${widget.totalSum} ${lang == 'uz' ? " so'm" : " сум"}',
            ),
            _divider(),
            _buildInfoItem(
              icon: Icons.person,
              title: lang == 'uz' ? "Buyurtmachi:" : "Клиент",
              value: 'Elshod',
            ),
            _divider(),
            _buildInfoItem(
              icon: Icons.phone,
              title: lang == 'uz' ? "Telefon raqamingiz:" : "Ваш номер телефона:",
              value: '+998 90 883 0450',
            ),
            _divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.redAccent),
                    const SizedBox(width: 6),
                    Text(
                      lang == 'uz' ? "Yetkazish manzili:" : "Адрес доставки",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Qarshi shaxar navo MFY",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                        overflow: TextOverflow.ellipsis,
                      ),
                      IconButton(
                        onPressed: () {
                          Get.to(()=>MapsPage());
                        },
                        icon: const Icon(Icons.edit, size: 20, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              lang == 'uz'
                  ? "Kuryer uchun qo'shimcha izoh"
                  : "Дополнительное объяснение для Курьера",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextField(
              minLines: 3,
              maxLines: 3,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                hintText: lang == 'uz'
                    ? "Masalan: lift ishlamaydi, eshik kodini yozing..."
                    : "Например: лифт не работает, напишите код двери...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart_checkout_rounded),
                label: Text(
                  lang == 'uz'
                      ? "Buyurtma tasdiqlash"
                      : "Подтверждение заказа",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Divider(color: Colors.grey.shade300, thickness: 1);
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 6),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
