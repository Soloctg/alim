import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_model.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/details', arguments: product);
      },
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(child: Image.asset(product.image, fit: BoxFit.cover)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("\$${product.price.toStringAsFixed(2)}"),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<CartModel>(
                        context,
                        listen: false,
                      ).add(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Added to cart")),
                      );
                    },
                    child: const Text("Add to Cart"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
