import 'package:flutter/material.dart';
import '../models/product.dart'; // ✅ This import is required
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: "Tomatoes",
      description: "Fresh farm tomatoes",
      price: 3.5,
      image: "assets/tomato.png",
    ),
    Product(
      name: "Vegetables",
      description: "Organic yams from local farmers",
      price: 10.0,
      image: "assets/vegetable.png",
    ),
    Product(
      name: "Eggs",
      description: "One crate of free-range eggs",
      price: 5.0,
      image: "assets/egg.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alimudo Farm Market"),
        backgroundColor: Color(0xFF8A4E2F),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}
