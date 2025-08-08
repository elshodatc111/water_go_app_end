import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_go_app_04_08_2025/const/color_const.dart';
import 'package:water_go_app_04_08_2025/screen/home/lists/lists_widget.dart';
import 'package:water_go_app_04_08_2025/screen/home/slider/slider_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final box = GetStorage();

  final List<Map<String, dynamic>> products = [
    {
      'id': 1,
      "name": "Bon Aqua Banner",
      "price": "12 000",
      "image": 'https://w0.peakpx.com/wallpaper/449/635/HD-wallpaper-water-splash-1080x960.jpg',
      "star": "4.5 (615)",
    },
    {
      'id': 2,
      "name": "Bon Aqua",
      "price": "12 000",
      "image": 'https://thumbs.dreamstime.com/b/pouring-water-bottle-glass-blue-background-32360015.jpg',
      "star": "4.5 (615)",
    },
    {
      'id': 3,
      "name": "Bon Aqua",
      "price": "12 000",
      "image": 'https://images8.alphacoders.com/110/1108778.jpg',
      "star": "4.5 (615)",
    },
    {
      'id': 4,
      "name": "Bon Aqua",
      "price": "12 000",
      "image": 'https://wallpapers.com/images/hd/sliced-orange-falling-in-the-water-rawhdotny5en8gk1.jpg',
      "star": "4.5 (615)",
    },
    {
      'id': 5,
      "name": "Bon Aqua",
      "price": "12 000",
      "image": 'https://cdn.wallpapersafari.com/63/18/O9WgEh.jpg',
      "star": "4.5 (615)",
    },
    {
      'id': 6,
      "name": "Bon Aqua",
      "price": "12 000",
      "image": 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrufOoIkl4eq3d4db86UHzmn9nLeT2qRgdyaUkpIqZFbRkI_1WIOHCvSuUCj0qsb289Hc&usqp=CAU',
      "star": "4.5 (615)",
    },
    {
      'id': 7,
      "name": "Bon Aqua",
      "price": "12 000",
      "image": 'https://www.aljazeera.net/wp-content/uploads/2022/03/shutterstock_366843809.jpg?resize=1800%2C1800',
      "star": "4.5 (615)",
    },
    {
      'id': 8,
      "name": "Bon Aqua",
      "price": "12 000",
      "image": 'https://cdn.alweb.com/thumbs/hotcoldcups/article/fit727x484/1/%D9%88%D8%B5%D9%81%D8%A7%D8%AA-%D8%B9%D8%B5%D9%8A%D8%B1-%D8%A7%D9%84%D8%A8%D8%B1%D8%AA%D9%82%D8%A7%D9%84.jpeg',
      "star": "4.5 (615)",
    }
  ];



  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final lang = box.read('lang') ?? 'uz';
    return Scaffold(
      appBar: AppBar(
        title: Text('WaterGo'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SliderWidget(),
            const SizedBox(height: 20),
            ListsWidget(products: products,),
          ],
        ),
      ),
    );
  }
}
