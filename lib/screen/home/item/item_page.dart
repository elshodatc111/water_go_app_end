import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_go_app_04_08_2025/screen/home/item/item_order_comment_page.dart';
import 'package:water_go_app_04_08_2025/screen/main_page.dart';

class ItemPage extends StatefulWidget {
  final int id;

  const ItemPage({super.key, required this.id});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final box = GetStorage();
  int _selectedIndex = 0;

  final Map<String, dynamic> list = {
    'id': 1,
    'name': "WaterGo",
    'star': 4.5,
    'order': 450,
    'star_comment': 45,
    'description':
    "Bu suv mahsuloti eng yuqori sifatli bo'lib, foydalanuvchilar orasida ommalashgan.",
    "item": [
      {
        'item_id': 1,
        'item_name': "5L",
        'item_image':
        "https://t4.ftcdn.net/jpg/09/28/89/41/360_F_928894187_2WfJCXsum0lmc43lx5lW5bo5muzZ9UTU.jpg",
        'item_price': 5000,
      },
      {
        'item_id': 2,
        'item_name': "10L",
        'item_image':
        "https://media.istockphoto.com/id/872635202/photo/big-bottle-of-water-on-a-white-background-3d-rendering.jpg?s=612x612&w=0&k=20&c=pPS7w6G56eJkftWKbCJzVStAiXYKSnWN7H4SPa0FqGQ=",
        'item_price': 8000,
      },
      {
        'item_id': 3,
        'item_name': "20L",
        'item_image':
        "https://5.imimg.com/data5/DK/GA/MY-10082152/fresh-and-pure-ro-water-500x500.jpg",
        'item_price': 11000,
      },
    ],
  };

  bool _isSelectedItemInCart() {
    List cart = box.read('cart') ?? [];
    final selectedItem = list['item'][_selectedIndex];
    return cart.any(
          (element) =>
      element['id'] == list['id'] &&
          element['item_name'] == selectedItem['item_name'],
    );
  }

  void _addToCart() {
    List cart = box.read('cart') ?? [];
    final selectedItem = list['item'][_selectedIndex];
    if (!_isSelectedItemInCart()) {
      cart.add({
        'id': list['id'],
        'name': list['name'],
        'item_name': selectedItem['item_name'],
        'item_id': selectedItem['item_id'],
        'item_price': selectedItem['item_price'],
        'item_image': selectedItem['item_image'],
      });
      box.write('cart', cart);
    }
    setState(() {});
  }

  Widget buildStarRating(double rating) {
    return Row(
      children: List.generate(5, (i) {
        if (rating >= i + 1) {
          return const Icon(Icons.star, color: Colors.amber, size: 20);
        } else if (rating > i) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 20);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber, size: 20);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedItem = list['item'][_selectedIndex];
    final lang = box.read('lang') ?? 'uz';

    return Scaffold(
      appBar: AppBar(
        title: Text(list['name']),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Stack(
                children: [
                  FadeInImage.assetNetwork(
                    placeholder: 'assets/images/card.jpg',
                    image: selectedItem['item_image'],
                    width: double.infinity,
                    height: 420,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (_, __, ___) {
                      return Image.asset(
                        'assets/images/card.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 420,
                      );
                    },
                  ),
                  Container(
                    height: 420,
                    color: Colors.black12,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    list['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 1.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  buildStarRating(list['star']),
                                  const SizedBox(width: 8),
                                  Text("${list['star']}"),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${list['order']} ${lang == 'uz' ? "ta buyurtma" : "заказ"}, (${list['star_comment']} ${lang == 'uz' ? "ta sharh" : "комментарий"})",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.to(() => ItemOrderCommentPage(id: widget.id));
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 24,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    lang == 'uz' ? "Mahsulot turlari:" : "Типы продуктов",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    children: List.generate(list['item'].length, (index) {
                      final item = list['item'][index];
                      final isSelected = index == _selectedIndex;
                      return ChoiceChip(
                        label: Text(
                          "${item['item_name']} - ${item['item_price']} ${lang == 'uz' ? "so'm" : "сум"}",
                          style: TextStyle(
                            color: isSelected ? Colors.blue : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (_) => setState(() {
                          _selectedIndex = index;
                        }),
                        selectedColor: Colors.blue.shade100,
                        backgroundColor: Colors.grey.shade200,
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    lang == 'uz' ? "Mahsulot haqida:" : "О продукте",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    list['description'],
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Builder(
        builder: (context) {
          final cart = box.read('cart') ?? [];
          final selectedItem = list['item'][_selectedIndex];
          final int cartCount = cart.length;

          return Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${selectedItem['item_price']} ${lang == 'uz' ? "so'm" : "сум"}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                _isSelectedItemInCart()
                    ? ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MainPage(selectedIndex: 1),
                      ),
                          (route) => false,
                    );
                  },
                  icon: const Icon(Icons.shopping_cart_outlined),
                  label: Text(
                    "${lang == 'uz' ? "Savat" : "В корзине"} ($cartCount)",
                  ),
                )
                    : ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: _addToCart,
                  icon: const Icon(Icons.add_shopping_cart),
                  label: Text(
                    lang == 'uz'
                        ? "Savatga qo'shish"
                        : "Добавить в корзину",
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
