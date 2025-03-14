import 'package:flutter/material.dart';
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column (
        children: [
          Text('This is my cart')
        ],
      
      ),
    );
  }
}