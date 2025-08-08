import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class UpdateProfilePage extends StatelessWidget {
  const UpdateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String lang = box.read('lang') ?? 'uz';
    final TextEditingController nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(lang=='uz'?"Ma'lumotlarni yangilash":"Обновить данные"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lang=='uz'?"Ismingiz":"Ваше имя",
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Colors.blue, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Colors.blue, width: 1.5),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Saqlash tugmasi
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {
                  final name = nameController.text.trim();
                  if (name.isNotEmpty) {}
                },
                child: Text(
                  lang=='uz'?"Yangilash":"Обновлять",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
