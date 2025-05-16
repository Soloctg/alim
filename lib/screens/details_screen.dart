import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int quantity = 1;
  String selectedSize = 'Medium';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF5EE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.brown),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset('assets/cappuccino1.png', height: 180),
            SizedBox(height: 20),
            Text(
              'Cappuccino',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('with chocolate and milk'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  ['Small', 'Medium', 'Large'].map((size) {
                    bool isSelected = size == selectedSize;
                    return GestureDetector(
                      onTap: () => setState(() => selectedSize = size),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isSelected ? Colors.brown : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          size,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed:
                      () => setState(() {
                        if (quantity > 1) quantity--;
                      }),
                ),
                Text('$quantity', style: TextStyle(fontSize: 20)),
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: () => setState(() => quantity++),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFD17B33),
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              ),
              onPressed: () {},
              child: Text('Add to cart'),
            ),
          ],
        ),
      ),
    );
  }
}
