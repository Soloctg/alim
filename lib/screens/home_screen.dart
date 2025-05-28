import 'package:alim/models/cart_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userEmail;

  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;
    final fullName = user?.displayName ?? 'Guest';
    setState(() {
      //userEmail = user?.email ?? 'Guest';
      //userEmail = user?.displayName ?? 'Guest';
      userEmail = fullName.split(' ').first;
    });
  }

  // Sample categorized products
  // In a real app, this data would likely come from a database or API

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
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                  ),
                  if (cart.items.isNotEmpty)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${cart.items.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (String value) {
              switch (value) {
                case 'settings':
                  Navigator.pushNamed(context, '/settings');
                  break;
                case 'logout':
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                  break;
              }
            },
            itemBuilder:
                (BuildContext context) => const [
                  PopupMenuItem<String>(
                    value: 'settings',
                    child: Text('Settings'),
                  ),
                  PopupMenuItem<String>(value: 'logout', child: Text('Logout')),
                ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, ${userEmail ?? 'User'}!',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ...categorizedProducts.entries.map((entry) {
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
            }),
          ],
        ),
      ),
    );
  }
}
