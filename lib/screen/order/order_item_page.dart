import 'package:flutter/material.dart';
class OrderItemPage extends StatefulWidget {
  final int id;
  const OrderItemPage({super.key, required this.id});

  @override
  State<OrderItemPage> createState() => _OrderItemPageState();
}

class _OrderItemPageState extends State<OrderItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("${widget.id}"),
    );
  }
}
