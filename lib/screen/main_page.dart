import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_go_app_04_08_2025/const/color_const.dart';
import 'package:water_go_app_04_08_2025/screen/home/home_page.dart';
import 'package:water_go_app_04_08_2025/screen/korzinka/korzinka_page.dart';
import 'package:water_go_app_04_08_2025/screen/order/order_page.dart';
import 'package:water_go_app_04_08_2025/screen/profile/profile_page.dart';

class MainPage extends StatefulWidget {
  final int selectedIndex;
  const MainPage({super.key, this.selectedIndex = 0});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _selectedIndex;
  final box = GetStorage();

  final List<Widget> _pages = [
    HomePage(),
    KorzinkaPage(),
    OrderPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex; // MUHIM: qiymat berildi
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      backgroundColor: ColorConst.bgWhite,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorConst.bg,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: box.read('lang') == 'uz' ? 'Asosiy' : 'Главный',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: box.read('lang') == 'uz' ? 'Savat' : 'Корзина',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time),
              label: box.read('lang') == 'uz' ? 'Buyurtma' : 'Заказы',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: box.read('lang') == 'uz' ? 'Profil' : 'Профиль',
            ),
          ],
        ),
      ),
    );
  }
}
