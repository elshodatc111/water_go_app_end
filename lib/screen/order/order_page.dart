import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_go_app_04_08_2025/screen/order/order_item_page.dart';
import 'package:water_go_app_04_08_2025/screen/order/widget/appbar_tab_widget.dart';
import 'package:water_go_app_04_08_2025/screen/widget/not_token_widget.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  Future<Map<String, dynamic>> _fetchOrders() async {
    await Future.delayed(const Duration(seconds: 1)); // simulyatsiya
    return {
      "messages": "Aktiv buyurtmalar",
      "active": [
        {
          'id': 1,
          "name": "WaterGo Bane 01",
          'isCurrent': 'new',
          'price': '12 000 UZS',
          'time': "20.07.2025 15:21",
          'image':
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdNClY2tS4NJ6_r2-CzoMdq-TSxgF1YQXYcw&s",
        },
        {
          'id': 2,
          "name": "WaterGo Bane 02",
          'isCurrent': 'accepted',
          'price': '15 000 UZS',
          'time': "20.07.2025 15:21",
          'image': "https://m.media-amazon.com/images/I/81tM3i3MEvL.png",
        },
        {
          'id': 3,
          "name": "WaterGo Bane 03",
          'isCurrent': 'pedding',
          'price': '5 000 UZS',
          'time': "20.07.2025 15:21",
          'image':
              "https://phoneky.co.uk/thumbs/android/thumbs/ico/6/s/water-drop-live-wallpaper-android.jpg",
        },
      ],
      "neactive": [
        {
          'id': 4,
          "name": "WaterGo Bane 04",
          'isCurrent': 'success',
          'price': '115 000 UZS',
          'time': "20.07.2025 15:21",
          'image':
              "https://i.pinimg.com/736x/69/44/2b/69442b1d0fcd0863ea827fb22186c115.jpg",
        },
        {
          'id': 5,
          "name": "WaterGo Bane 05",
          'isCurrent': 'success',
          'price': '80 000 UZS',
          'time': "20.07.2025 15:21",
          'image':
              "https://thumbs.dreamstime.com/b/water-drop-icon-set-vector-raindrop-silhouette-water-drop-icon-set-vector-raindrop-silhouette-design-elements-99506726.jpg",
        },
        {
          'id': 6,
          "name": "WaterGo Bane 06",
          'isCurrent': 'cancel',
          'price': '526 000 UZS',
          'time': "20.07.2025 15:21",
          'image':
              "https://i.pinimg.com/736x/69/44/2b/69442b1d0fcd0863ea827fb22186c115.jpg",
        },
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');
    final lang = box.read('lang') ?? 'uz';

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          centerTitle: true,
          title: AppbarTabWidget(lang: lang),
        ),
        body:
            token == null
                ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: NotTokenWidget(lang: lang)),
                )
                : FutureBuilder<Map<String, dynamic>>(
                  future: _fetchOrders(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData) {
                      return const Center(child: Text("Ma'lumot yuklanmadi"));
                    }
                    final activeOrders =
                        snapshot.data!["active"] as List<dynamic>;
                    final neactiveOrders =
                        snapshot.data!["neactive"] as List<dynamic>;
                    return TabBarView(
                      children: [
                        activeOrders.length != 0
                            ? _orderList(lang, activeOrders)
                            : emptyItem(lang, 'active'),
                        neactiveOrders.length != 0
                            ? _orderList(lang, neactiveOrders)
                            : emptyItem(lang, 'success'),
                      ],
                    );
                  },
                ),
      ),
    );
  }

  Widget emptyItem(String lang, String type) {
    final String title =
        type == 'active'
            ? lang == 'uz'
                ? "Sizda aktiv buyurtmalar mavjud emas."
                : "У вас нет активных заказов."
            : lang == 'uz'
            ? "Sizda buyurtmalar mavjud emas."
            : "У вас нет заказов.";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/empte.png', height: 180),
          const SizedBox(height: 24),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _orderList(String lang, List<dynamic> orders) {
    return RefreshIndicator(
      onRefresh: () async => _fetchOrders(),
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return _orderCard(
            order['id'],
            order["name"],
            price: order["price"],
            date: order["time"],
            imageUrl: order["image"],
            status: order["isCurrent"],
            lang: lang,
          );
        },
      ),
    );
  }

  Widget _orderCard(
    int id,
    String name, {
    required String price,
    required String date,
    required String imageUrl,
    required String status,
    required String lang,
  }) {
    Color statusColor;
    String isStatus;
    switch (status) {
      case 'new':
        statusColor = Colors.blueAccent;
        isStatus = "Yangi";
        break;
      case 'accepted':
        statusColor = Colors.blue.shade200;
        isStatus = "Qabul qilindi";
        break;
      case 'pedding':
        statusColor = Colors.orange;
        isStatus = "Yetqazilmoqda";
        break;
      case 'success':
        statusColor = Colors.green;
        isStatus = "Yakunlandi";
        break;
      case 'cancel':
        statusColor = Colors.red;
        isStatus = "Bekor qilindi";
        break;
      default:
        statusColor = Colors.grey;
        isStatus = "";
    }

    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: statusColor.withOpacity(0.5)),
        ),
        color: Colors.white,
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Image.asset(
                  'assets/images/card.jpg', // default rasm
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/card.jpg', // agar link xato bo‘lsa
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(price),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                isStatus,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                date,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Get.to(() => OrderItemPage(id: id));
      },
    );
  }
}
