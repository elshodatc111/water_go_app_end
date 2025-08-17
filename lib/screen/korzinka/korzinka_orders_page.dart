import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_go_app_04_08_2025/screen/korzinka/maps_page.dart';
import 'package:water_go_app_04_08_2025/screen/korzinka/orders_success_page.dart';

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
  final TextEditingController _noteController = TextEditingController();
  String deliveryAddress = '';
  String lang = 'uz';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final storage = GetStorage();
    deliveryAddress = storage.read('addres') ?? '';
    lang = storage.read('lang') ?? 'uz';
  }

  Future<void> _confirmOrder() async {
    setState(() {
      _isLoading = true;
    });

    // API'ga yuboriladigan ma'lumotlar
    final orderPayload = {
      "products": widget.orderData, // [{id: 1, quantity: 1},{id: 2, quantity: 3}]
      "token": GetStorage().read('token') ?? '',
      "address": GetStorage().read('address') ?? '',
      "latitude": GetStorage().read('latitude') ?? '',
      "longitude": GetStorage().read('longitude') ?? '',
    };
    print("📤 APIga yuborilayotgan ma'lumotlar:");
    print(orderPayload);
    await Future.delayed(const Duration(seconds: 2));
    final storage = GetStorage();
    storage.remove('cart'); // Savatni bo‘shatish
    print("🛒 Cart ma'lumotlari tozalandi!");

    setState(() {
      _isLoading = false;
    });

    // Buyurtma muvaffaqiyatli bo'ldi sahifasiga o'tish
    Get.offAll(() => const OrdersSuccessPage());
  }

  @override
  Widget build(BuildContext context) {
    final mainColor = Colors.blue;
    final bool isAddressSet = deliveryAddress.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          lang == 'uz' ? "Buyurtmani tasdiqlash" : "Подтверждение заказа",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: mainColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            _infoCard(
              icon: Icons.inventory_rounded,
              title: lang == 'uz' ? "Mahsulot soni" : "Количество товаров",
              value: '${widget.totalQuantity}',
              color: mainColor,
            ),
            _infoCard(
              icon: Icons.monetization_on_rounded,
              title: lang == 'uz' ? "Umumiy narx" : "Общая цена",
              value: '${widget.totalSum} ${lang == 'uz' ? "so\'m" : "сум"}',
              color: mainColor,
            ),
            _infoCard(
              icon: Icons.person_outline_rounded,
              title: lang == 'uz' ? "Buyurtmachi" : "Клиент",
              value: GetStorage().read('name') ?? '',
              color: mainColor,
            ),
            _infoCard(
              icon: Icons.phone_iphone_rounded,
              title: lang == 'uz' ? "Telefon raqami" : "Номер телефона",
              value: GetStorage().read('phone') ?? '',
              color: mainColor,
            ),
            _addressCard(mainColor),
            _noteField(mainColor),
            const SizedBox(height: 20),
            _confirmButton(mainColor, isAddressSet),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: color, width: 1.2),
      ),
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget _addressCard(Color mainColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: mainColor, width: 1.2),
      ),
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          child: const Icon(Icons.location_on_rounded, color: Colors.redAccent),
        ),
        title: Text(
          lang == 'uz' ? "Yetkazish manzili" : "Адрес доставки",
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          deliveryAddress.isNotEmpty
              ? deliveryAddress
              : (lang == 'uz' ? "Manzil tanlanmagan" : "Адрес не выбран"),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: deliveryAddress.isEmpty ? Colors.red : Colors.black,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.edit_location_alt_rounded, color: mainColor),
          onPressed: () async {
            await Get.to(() => const MapsPage());
            setState(() {
              deliveryAddress = GetStorage().read('addres') ?? '';
            });
          },
        ),
      ),
    );
  }

  Widget _noteField(Color mainColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: mainColor, width: 1.2),
      ),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lang == 'uz'
                  ? "Kuryer uchun qo'shimcha izoh"
                  : "Дополнительное объяснение для Курьера",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _noteController,
              minLines: 3,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: lang == 'uz'
                    ? "Izoh matni..."
                    : "Текст пояснения...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _confirmButton(Color mainColor, bool isAddressSet) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: isAddressSet ? mainColor : Colors.grey,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: isAddressSet && !_isLoading ? _confirmOrder : null,
        icon: _isLoading
            ? const SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : const Icon(Icons.check_circle_outline_rounded, color: Colors.white),
        label: Text(
          _isLoading
              ? (lang == 'uz' ? "Yuborilmoqda..." : "Отправка...")
              : (lang == 'uz' ? "Buyurtma tasdiqlash" : "Подтверждение заказа"),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
