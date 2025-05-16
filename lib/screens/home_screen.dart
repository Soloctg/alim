import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> coffeeList = [
    {
      'name': 'Cappuccino',
      'description': 'Turkish coffee',
      'price': 25.00,
      'image': 'assets/cappuccino1.png',
    },
    {
      'name': 'Cappuccino',
      'description': 'Brown chocolate mug',
      'price': 25.00,
      'image': 'assets/cappuccino2.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/profile.jpg'), // optional
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications, color: Colors.black87),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lagos, Nigeria',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Color(0xFFF4F4F4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFFFE0B2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Buy one, Get one for Free",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("Coffee Yard Time: 9:00 am - 5:30 pm"),
                      ],
                    ),
                  ),
                  Image.asset('assets/offer.png', height: 60),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ChoiceChip(
                  label: Text("Cappuccino"),
                  selected: true,
                  selectedColor: Colors.brown.shade200,
                ),
                SizedBox(width: 8),
                ChoiceChip(label: Text("Cold Brew"), selected: false),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: coffeeList.length,
                itemBuilder: (context, index) {
                  final coffee = coffeeList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/details');
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: EdgeInsets.only(bottom: 16),
                      elevation: 2,
                      child: ListTile(
                        leading: Image.asset(coffee['image'], height: 50),
                        title: Text(coffee['name']),
                        subtitle: Text(coffee['description']),
                        trailing: Text('\$${coffee['price']}'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
