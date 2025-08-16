import 'package:flutter/material.dart';

class OrderCancelPage extends StatefulWidget {
  final int id;

  const OrderCancelPage({super.key, required this.id});

  @override
  State<OrderCancelPage> createState() => _OrderCancelPageState();
}

class _OrderCancelPageState extends State<OrderCancelPage> {
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isReasonFilled = _reasonController.text.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Buyurtmani bekor qilish")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Bekor qilish sababini kiriting",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _reasonController,
              maxLines: 4,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: "_",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const Spacer(),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed:
                  isReasonFilled
                      ? () {
                        final reason = _reasonController.text.trim();
                        print("###############################: ${reason}");
                        print("###############################: ${widget.id}");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Buyurtma bekor qilindi"),
                            backgroundColor: Colors.red,
                          ),
                        );
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                      : null,
              child: const Text(
                "Bekor qilish",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
