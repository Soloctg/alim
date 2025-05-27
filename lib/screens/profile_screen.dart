import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profile"),
        backgroundColor: const Color.fromRGBO(138, 78, 47, 1),
        foregroundColor: Colors.white,
      ),
      body:
          user == null
              ? const Center(child: Text("Not logged in"))
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Account Information",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(user.displayName ?? "No display name"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: Text(user.email ?? "No email"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.verified_user),
                      title: Text(
                        user.emailVerified
                            ? "Email Verified"
                            : "Email Not Verified",
                      ),
                    ),
                    const Spacer(),
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
