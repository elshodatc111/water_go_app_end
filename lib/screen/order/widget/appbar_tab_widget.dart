import 'package:flutter/material.dart';
class AppbarTabWidget extends StatefulWidget {
  final String lang;
  const AppbarTabWidget({super.key, required this.lang});

  @override
  State<AppbarTabWidget> createState() => _AppbarTabWidgetState();
}

class _AppbarTabWidgetState extends State<AppbarTabWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tabWidth = constraints.maxWidth * 0.4;
          return TabBar(
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              SizedBox(
                width: tabWidth,
                child: Tab(text: widget.lang == 'uz' ? "Hozirgi" : "Текущие"),
              ),
              SizedBox(
                width: tabWidth,
                child: Tab(text: widget.lang == 'uz' ? "Avvalgi" : "Предыдущие"),
              ),
            ],
          );
        },
      ),
    );
  }
}
