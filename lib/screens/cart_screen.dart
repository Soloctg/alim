import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // In real apps, you'd pass selected cart items via a state manager (like Provider)
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        backgroundColor: Color(0xFF8A4E2F),
      ),
      body: Center(
        child: Text("Your cart is empty", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
