import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Map<String, List<Product>> categorizedProducts = {
    'Vegetables': [
      Product(
        name: "Tomatoes",
        description: "Fresh farm tomatoes",
        price: 3.5,
        image: "assets/tomato.png",
      ),
      Product(
        name: "Leafy Greens",
        description:
            "Well planted and nurtured with manure from our poultry farm, the fluted pumpkin is a good source of protein.",
        price: 4.0,
        image: "assets/vegetable.png",
      ),
      Product(
        name: "Dragon Fruit",
        description: "Fresh farm dragon fruit",
        price: 2.5,
        image: "assets/dragonFruit.jpg",
      ),
    ],
    'Dairy': [
      Product(
        name: "Eggs",
        description: "Crate of free-range eggs",
        price: 5.0,
        image: "assets/egg.png",
      ),
      Product(
        name: "Chicken Gizzard",
        description: "Tender chicken gizzard, fresh and protein-rich.",
        price: 5.0,
        image: "assets/dragonFruit.jpg",
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alimudo Farm Market"),
        backgroundColor: const Color.fromRGBO(138, 78, 47, 1),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              categorizedProducts.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[300],
                      ),
                    ),
                    const SizedBox(height: 10),
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.75,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children:
                          entry.value
                              .map((product) => ProductCard(product: product))
                              .toList(),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }
}
