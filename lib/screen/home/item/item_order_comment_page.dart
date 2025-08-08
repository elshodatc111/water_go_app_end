import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ItemOrderCommentPage extends StatefulWidget {
  final int id;
  const ItemOrderCommentPage({super.key, required this.id});
  @override
  State<ItemOrderCommentPage> createState() => _ItemOrderCommentPageState();
}

class _ItemOrderCommentPageState extends State<ItemOrderCommentPage> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final lang = box.read('lang') ?? 'uz';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          lang == 'uz' ? "Sharhlar" : "Комментарии",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: 20,
        itemBuilder: (ctx, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.white,
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Elshod Musurmonov",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      starItem(3),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Buyurtma haqida qoldirilgan izoh. Juda sifatli mahsulot, tez yetkazib berildi.",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 6),
                  // Sana
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(Icons.access_time, size: 14, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        "08-08-2025 15:45",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget starItem(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          size: 16,
          color: index < rating ? Colors.amber : Colors.grey,
        );
      }),
    );
  }
}
