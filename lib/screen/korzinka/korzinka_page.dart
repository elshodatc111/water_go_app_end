import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_go_app_04_08_2025/screen/auth/auth_phone_page.dart';
import 'package:water_go_app_04_08_2025/screen/korzinka/korzinka_orders_page.dart';
import 'package:water_go_app_04_08_2025/screen/korzinka/widget/not_corzinka_widget.dart';

class KorzinkaPage extends StatefulWidget {
  const KorzinkaPage({super.key});

  @override
  State<KorzinkaPage> createState() => _KorzinkaPageState();
}

class _KorzinkaPageState extends State<KorzinkaPage> {
  final box = GetStorage();
  List<Map<String, dynamic>> cart = [];
  late String lang;
  late String token;

  @override
  void initState() {
    super.initState();

    // Savatni o‘qish
    final storedCart = box.read('cart') ?? [];
    try {
      cart = List<Map<String, dynamic>>.from(
        (storedCart as List).map((e) => Map<String, dynamic>.from(e as Map)),
      );
      for (var item in cart) {
        item['quantity'] = (item['quantity'] ?? 1).clamp(1, 999);
      }
    } catch (_) {
      cart = [];
    }

    lang = box.read('lang') ?? 'uz';
    token = box.read('token') ?? '';
  }

  void _removeItem(int index) {
    setState(() {
      cart.removeAt(index);
      box.write('cart', cart);
    });
  }

  void _updateQuantity(int index, int delta) {
    setState(() {
      final currentQty = cart[index]['quantity'] ?? 1;
      final newQty = currentQty + delta;
      if (newQty <= 0) {
        _removeItem(index);
      } else {
        cart[index]['quantity'] = newQty;
        box.write('cart', cart);
      }
    });
  }

  int get totalQuantity =>cart.fold(0, (sum, item) => sum + ((item['quantity'] ?? 1) as num).toInt());

  int get totalSum => cart.fold(
      0,
          (sum, item) =>
      sum +
          (((item['item_price'] ?? 0) as num).toInt() *
              ((item['quantity'] ?? 1) as num).toInt()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'uz' ? "Savat" : "Корзина"),
        centerTitle: true,
      ),
      body: cart.isEmpty
          ? const NotCorzinkaWidget()
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final product = cart[index];
                return _buildItem(product, index);
              },
            ),
          ),
          _buildSummarySection(),
        ],
      ),
    );
  }

  Widget _buildItem(Map<String, dynamic> product, int index) {
    final imageUrl = (product['item_image'] ?? '').toString().trim();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blueAccent, width: 1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: imageUrl.isNotEmpty
                ? Image.network(
              imageUrl,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _defaultImage(),
            )
                : _defaultImage(),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${product['name'] ?? ''} (${product['item_name'] ?? ''})",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  lang == 'uz'
                      ? "${product['item_price']} so'm"
                      : "${product['item_price']} сум",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => _updateQuantity(index, -1),
                icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
              ),
              Text(
                "${product['quantity']}",
                style: const TextStyle(fontSize: 16),
              ),
              IconButton(
                onPressed: () => _updateQuantity(index, 1),
                icon: const Icon(Icons.add_circle_outline, color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$totalSum ${lang == 'uz' ? "so'm" : "сум"}",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "$totalQuantity ${lang == 'uz' ? "ta mahsulot" : "продукт"}",
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              final orderData = cart
                  .map((item) => {
                'id': item['item_id'],
                'quantity': item['quantity'],
              })
                  .toList();

              if (token.isEmpty) {
                Get.to(() => AuthPhonePage());
              } else {
                Get.to(() => KorzinkaOrdersPage(
                  orderData: orderData,
                  totalSum: totalSum,
                  totalQuantity: totalQuantity,
                ));
              }
            },
            icon: const Icon(Icons.shopping_cart_checkout),
            label: Text(lang == 'uz' ? "Buyurtma berish" : "Разместить заказ"),
          ),
        ],
      ),
    );
  }

  Widget _defaultImage() {
    return Container(
      width: 72,
      height: 72,
      color: Colors.grey.shade200,
      child: const Icon(Icons.image_not_supported),
    );
  }
}
