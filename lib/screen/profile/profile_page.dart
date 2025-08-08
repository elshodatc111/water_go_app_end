import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_go_app_04_08_2025/screen/auth/contact_us_page.dart';
import 'package:water_go_app_04_08_2025/screen/auth/oferta_page.dart';
import 'package:water_go_app_04_08_2025/screen/profile/update_profile_page.dart';
import 'package:water_go_app_04_08_2025/screen/widget/not_token_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');
    final lang = box.read('lang') ?? 'uz';

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'uz' ? "Profil" : "Профиль"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: token == null
            ? NotTokenWidget(lang: lang)
            : _buildProfile(context, lang),
      ),
    );
  }

  Widget _buildProfile(BuildContext context, String lang) {
    final String fullName = "Elshod Musurmonov";
    final String phone = "+998 94 520 4004";
    return Column(
      children: [
        const SizedBox(height: 20),
        CircleAvatar(
          radius: 45,
          backgroundColor: Colors.blue.shade100,
          child: const Icon(Icons.person, size: 60, color: Colors.blue),
        ),
        const SizedBox(height: 12),
        Text(
          fullName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          phone,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 30),
        _menuTile(
          icon: Icons.edit,
          title: lang == 'uz' ? "Ma'lumotlarni yangilash" : "Обновить данные",
          onTap: () {
            Get.to(()=>UpdateProfilePage());
          },
        ),
        _menuTile(
          icon: Icons.phone,
          title: lang == 'uz' ? "Biz bilan aloqa" : "Связаться с нами",
          onTap: () {
            Get.to(()=>ContactUsPage());
          },
        ),
        _menuTile(
          icon: Icons.article,
          title: lang == 'uz' ? "Foydalanish shartlari" : "Условия использования",
          onTap: () {
            Get.to(()=>OfertaPage());
          },
        ),
        _menuTile(
          icon: Icons.logout,
          title: lang == 'uz' ? "Akkountdan chiqish" : "Выйти из аккаунта",
          onTap: () {
            _showLogoutDialog(context, lang);
          },
          color: Colors.red,
        ),
        const Spacer(),
        Text(
          "1.11.0 (production)",
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _menuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: color ?? Colors.blue),
        title: Text(
          title,
          style: TextStyle(
            color: color ?? Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, String lang) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(lang == 'uz' ? "Chiqish" : "Выход"),
        content: Text(lang == 'uz'
            ? "Haqiqatan ham akkauntdan chiqmoqchimisiz?"
            : "Вы действительно хотите выйти из аккаунта?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(lang == 'uz' ? "Bekor qilish" : "Отмена"),
          ),
          ElevatedButton(
            onPressed: () {
              final box = GetStorage();
              box.remove('token');
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(lang == 'uz' ? "Chiqish" : "Выйти",style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
