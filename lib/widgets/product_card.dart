import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/details', arguments: product);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(child: Image.asset(product.image, fit: BoxFit.cover)),
              SizedBox(height: 5),
              Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
