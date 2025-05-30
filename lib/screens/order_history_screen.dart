import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        backgroundColor: const Color.fromRGBO(138, 78, 47, 1),
        foregroundColor: Colors.white,
      ),
      //backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/home');
        },
        backgroundColor: const Color.fromRGBO(138, 78, 47, 1),
        child: const Icon(Icons.home, color: Colors.white),
      ),
      body:
          currentUser == null
              ? const Center(child: Text("Please login to view your orders."))
              : StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance
                        .collection('orders')
                        .where('userId', isEqualTo: currentUser.uid)
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        "No orders yet.",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final order = snapshot.data!.docs[index];

                      final email = order['userEmail'];
                      final userId = order['userId'];
                      if (email != currentUser.email ||
                          userId != currentUser.uid) {
                        return const SizedBox.shrink(); // Skip orders not belonging to the current user
                      }
                      final total = order['total'];
                      final location = order['location'];
                      final timestamp = order['timestamp']?.toDate();
                      final productList = List.from(order['items']);

                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ExpansionTile(
                          title: Text(
                            'Total: \$${total.toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Delivered to: $location\nEmail: $email\n${timestamp != null ? timestamp.toString().substring(0, 19) : ''}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          children:
                              productList.map<Widget>((product) {
                                return ListTile(
                                  leading: Image.asset(
                                    product['image'],
                                    width: 40,
                                    height: 40,
                                  ),
                                  title: Text(product['name']),
                                  subtitle: Text(
                                    "\$${product['price'].toStringAsFixed(2)}",
                                  ),
                                );
                              }).toList(),
                        ),
                      );
                    },
                  );
                },
              ),
    );
  }
}
