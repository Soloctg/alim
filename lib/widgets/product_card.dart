import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: EdgeInsets.all(12),
        leading: Image.asset(product.image, width: 60, fit: BoxFit.cover),
        title: Text(product.name),
        subtitle: Text(product.description),
        trailing: Text('\$${product.price.toString()}'),
        onTap: () {
          Navigator.pushNamed(context, '/details', arguments: product);
        },
      ),
    );
  }
}
