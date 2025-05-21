import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        backgroundColor: const Color.fromRGBO(138, 78, 47, 1),
        foregroundColor: Colors.white,
      ),
      body:
          cart.items.isEmpty
              ? const Center(
                child: Text(
                  "Your cart is empty!",
                  //style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              )
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) {
                        final item = cart.items[index];
                        return ListTile(
                          leading: Image.asset(item.image, width: 50),
                          title: Text(item.name),
                          textColor: Colors.white,

                          subtitle: Text("\$${item.price.toStringAsFixed(2)}"),
                          iconColor: Colors.red,
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => cart.remove(item),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Implement checkout logic here
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Order placed!")),
                            );
                            //cart.clear(); // clear cart after checkout
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ),
                          child: const Text("Checkout"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
