import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
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
        description: "Fresh leafy vegetables",
        price: 4.0,
        image: "assets/vegetable.png",
      ),
    ],
    'Dairy': [
      Product(
        name: "Eggs",
        description: "Crate of free-range eggs",
        price: 5.0,
        image: "assets/egg.png",
      ),
    ],
  };

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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
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
                    SizedBox(height: 10),
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children:
                          entry.value
                              .map((product) => ProductCard(product: product))
                              .toList(),
                    ),
                    SizedBox(height: 20),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }
}
