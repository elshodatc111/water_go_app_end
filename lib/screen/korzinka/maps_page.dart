import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Yetqazib berish manzili")),
      body: Center(
        child: TextButton(onPressed: () {
          final storage = GetStorage();
          storage.write('addres',"Qarshi shaxar navo MFY11");
          storage.write('latude',"38.83853181");
          storage.write('longtude',"65.77204028");
        }, child: Text("Tasdiqlash")),
      ),
    );
  }
}
