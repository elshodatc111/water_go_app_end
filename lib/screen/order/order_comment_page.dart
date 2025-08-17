import 'package:flutter/material.dart';

class OrderCommentPage extends StatefulWidget {
  final int orderId;
  final String lang;
  const OrderCommentPage({super.key, required this.orderId, required this.lang});

  @override
  State<OrderCommentPage> createState() => _OrderCommentPageState();
}

class _OrderCommentPageState extends State<OrderCommentPage> {
  int _selectedStars = 0; // yulduzlar uchun
  final TextEditingController _commentController = TextEditingController();

  void _submitReview() {
    final rating = _selectedStars;
    final comment = _commentController.text.trim();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Baholash yuborildi! ⭐ $rating\nIzoh: $comment"),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context); // sahifani yopish
  }

  Widget _buildStar(int index) {
    return IconButton(
      onPressed: () {
        setState(() {
          _selectedStars = index;
        });
      },
      icon: Icon(
        index <= _selectedStars ? Icons.star : Icons.star_border,
        color: Colors.amber,
        size: 36,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lang=='uz'?"Buyurtmani baholash":"Заказать оценку"),
        elevation: 2,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) => _buildStar(index + 1)),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.lang=='uz'?"Izoh (majburiy emas):":"Комментарий (необязательно):",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: widget.lang=='uz'?"Buyurtma haqida izoh qoldiring...":"Оставьте комментарий о заказе...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedStars > 0 ? _submitReview : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  widget.lang=='uz'?"Baholash":"Оценка",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
