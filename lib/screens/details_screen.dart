import 'package:flutter/material.dart';
import '../models/product.dart';
//import 'package:provider/provider.dart';
//import '../models/cart_model.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Color(0xFF8A4E2F),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(
              product.image,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(product.description, style: TextStyle(fontSize: 16)),

            Text(
              '\$${product.price.toString()}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
              child: Text("Add to Cart"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFB54C),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: StadiumBorder(),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
