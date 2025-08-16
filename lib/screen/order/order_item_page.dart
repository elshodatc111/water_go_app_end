import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:water_go_app_04_08_2025/screen/order/order_cancel_page.dart';

class OrderItemPage extends StatefulWidget {
  final int id;

  const OrderItemPage({super.key, required this.id});

  @override
  State<OrderItemPage> createState() => _OrderItemPageState();
}

class _OrderItemPageState extends State<OrderItemPage> {
  final token = GetStorage().read('token');
  final lang = GetStorage().read('lang') ?? 'uz';

  Future<Map<String, dynamic>> loadItem() async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      "id": 1,
      "orderId": "#1",
      "name": "WaterGo",
      "status": "new", // new, accepted, pedding, success, cancel
      "orderCount": 8,
      "orderPrice": "25 000 USD",
      "data": {
        'newData': "23-01-2025 15:45",
        'acceptedData': "23-01-2025 15:45",
        'successData': "23-01-2025 15:45",
        'cancelData': "23-01-2025 15:45",
      },
      "item": [
        {'name': "10L", 'calc': '2.0x7 000 = 14 000'},
        {'name': "5L", 'calc': '3.0x5 000 = 15 000'},
      ],
      "courier": "Elshod Musurmonov",
      "courierPhone": "+998908830451",
      "operator": "+998908830450",
    };
  }

  /// Operatorga qo'ng'iroq qilish funksiyasi
  Future<void> _callOperator(String phone) async {
    final Uri url = Uri(scheme: 'tel', path: phone);

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Qo'ng'iroq qilib bo'lmadi: $phone")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Xatolik: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // oq fon
      appBar: AppBar(
        title: const Text("Buyurtma haqida"),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: loadItem(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Xatolik: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final item = snapshot.data!;
            return OrderItem(item, lang);
          } else {
            return const Center(child: Text("Ma'lumot topilmadi"));
          }
        },
      ),
    );
  }

  Widget OrderItem(Map<String, dynamic> item, String lang) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          /// Buyurtma nomi va raqami
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${item['name']}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "${item['orderId']}",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.grey[700]),
              ),
            ],
          ),
          const Divider(),

          /// Mahsulotlar ro‘yxati
          ...List.generate(item['item'].length, (index) {
            var product = item['item'][index];
            return ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text("${index + 1}. ${product['name']}", style: TextStyle(fontSize: 16.0),),
              trailing: Text(product['calc'], style: TextStyle(fontSize: 16.0),),
            );
          }),

          const Divider(),
          ItemWidget(
            lang == 'uz' ? "Buyurtma soni:" : "Номер заказа:",
            "${item['orderCount']}",
          ),
          ItemWidget(
            lang == 'uz' ? "Buyurtma narxi:" : "Стоимость заказа:",
            "${item['orderPrice']}",
          ),
          ItemWidget(
            lang == 'uz' ? "Holat:" : "Статус:",
            _statusText(item['status'], lang),
          ),
          ItemWidget(
            lang == 'uz' ? "Buyurtma vaqti:" : "Время заказа:",
            "${item['data']['newData']}",
          ),

          if (item['status'] != 'new')
            ItemWidget(
              lang == 'uz' ? "Qabul qilindi:" : "Принято:",
              "${item['data']['acceptedData']}",
            ),

          if (item['status'] == 'success') ...[
            ItemWidget(
              lang == 'uz' ? "Yetkazildi:" : "Доставлено:",
              "${item['data']['successData']}",
            ),
            ItemWidget(
              lang == 'uz' ? "Kuryer:" : "Курьер:",
              "${item['courier']}",
            ),
          ],

          if (item['status'] == 'cancel')
            ItemWidget(
              lang == 'uz' ? "Bekor qilindi:" : "Отменено:",
              "${item['data']['cancelData']}",
            ),

          const SizedBox(height: 20),

          /// Tugmalar (Material 3 style)
          if (item['status'] == 'new')
            Column(
              children: [
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size.fromHeight(48),
                  ),
                  onPressed: () {
                    Get.to(() => OrderCancelPage(id: widget.id));
                  },
                  child: Text(
                    lang == 'uz'
                        ? "Buyurtmani bekor qilish"
                        : "Отмена заказа",
                  ),
                ),
                SizedBox(height: 16.0,),
              ],
            ),
          if (item['status'] == 'pedding')
            Column(
              children: [
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size.fromHeight(48),
                  ),
                  onPressed: () {
                    _callOperator(item['courierPhone']);
                  },
                  child: Text(
                    lang == 'uz'
                        ? "Kuryer bilan bog'lanish"
                        : "Связаться с курьером",
                  ),
                ),SizedBox(height: 16.0,)
              ],
            ),

          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
            ),
            onPressed: () {
              _callOperator(item['operator']);
            },
            icon: const Icon(Icons.phone),
            label: Text(
              lang == 'uz'
                  ? "Operator bilan bog'lanish"
                  : "Связаться с оператором",
            ),
          ),
        ],
      ),
    );
  }

  Widget ItemWidget(String name, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: Theme.of(context).textTheme.bodyLarge),
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  /// Status tarjimasi
  String _statusText(String status, String lang) {
    switch (status) {
      case 'new':
        return lang == 'uz' ? "Yangi" : "Новый";
      case 'accepted':
        return lang == 'uz' ? "Qabul qilindi" : "Принято";
      case 'pedding':
        return lang == 'uz' ? "Yetkazilmoqda" : "Доставка";
      case 'success':
        return lang == 'uz' ? "Yetkazildi" : "Доставлено";
      case 'cancel':
        return lang == 'uz' ? "Bekor qilindi" : "Отменено";
      default:
        return "-";
    }
  }
}
