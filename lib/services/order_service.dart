import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

Future<void> saveOrder({
  required String location,
  required List<Product> items,
  required double total,
}) async {
  final firestore = FirebaseFirestore.instance;

  await firestore.collection('orders').add({
    'location': location,
    'total': total,
    'timestamp': FieldValue.serverTimestamp(),
    'items':
        items
            .map(
              (item) => {
                'name': item.name,
                'price': item.price,
                'image': item.image,
              },
            )
            .toList(),
  });
}
