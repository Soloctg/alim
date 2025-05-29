import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;

  String? userName;
  String? phone;
  String? address;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserName();
    // Fetch user phone number if available (handled in _fetchUserName)
  }

  Future<void> _fetchUserName() async {
    if (user != null) {
      try {
        final doc =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user!.uid)
                .get();

        if (doc.exists) {
          final data = doc.data();
          log("Firestore user data: $data");

          setState(() {
            userName = doc.data()?['name'] ?? user!.displayName;
            address = data?['address'] ?? 'No address available';
            phone = data?['phone'] ?? user!.phoneNumber ?? 'No phone number';

            nameController.text = userName ?? '';
            phoneController.text = phone ?? '';
            addressController.text = address ?? '';
          });
        } else {
          setState(() {
            userName = user!.displayName;
            address = 'No address available';
            phone = user!.phoneNumber ?? 'No phone number';

            nameController.text = userName ?? '';
            phoneController.text = phone ?? '';
            addressController.text = address ?? '';
          });
        }
      } catch (error) {
        log('Error fetching user name', error: error);
        setState(() {
          userName = user!.displayName;
          address = 'Error loading address';
          phone = user!.phoneNumber ?? 'Error loading phone number';

          nameController.text = userName ?? '';
          phoneController.text = phone ?? '';
          addressController.text = address ?? '';
        });
      }
    }
  }

  Future<void> _saveProfile() async {
    if (user == null) return;
    try {
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'name': nameController.text,
        'phone': phoneController.text,
        'address': addressController.text,
      }, SetOptions(merge: true));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to update profile: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if user is logged in
    if (user == null) {
      return const Scaffold(body: Center(child: Text("Not logged in")));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profile"),
        backgroundColor: const Color.fromRGBO(138, 78, 47, 1),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "Edit Account Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                prefixIcon: Icon(Icons.person),
              ),
              onChanged: (value) {
                setState(() {
                  userName = value;
                });
              },
            ),

            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: "Phone Number",
                prefixIcon: Icon(Icons.phone),
              ),
              onChanged: (value) {
                setState(() {
                  phone = value;
                });
              },
            ),

            const SizedBox(height: 16),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: "Address",
                prefixIcon: Icon(Icons.location_on),
              ),
              onChanged: (value) {
                setState(() {
                  address = value;
                });
              },
            ),
            const SizedBox(height: 16),
            // Display user email
            const Text(
              "Email",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(user?.email ?? "No email available"),
            ),

            const SizedBox(height: 24),
            // Save button
            Center(
              child: ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(138, 78, 47, 1),
                  foregroundColor: Colors.white,
                ),
                child: const Text("Save Changes"),
              ),
            ),
            Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(138, 78, 47, 1),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
