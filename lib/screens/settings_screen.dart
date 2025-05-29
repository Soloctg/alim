import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: const Color.fromRGBO(138, 78, 47, 1),
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            const SizedBox(height: 20),

            // Profile
            ListTile(
              leading: const Icon(Icons.person, color: Colors.brown),
              title: const Text("Profile"),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            const Divider(),

            // Order History
            ListTile(
              leading: const Icon(Icons.history, color: Colors.brown),
              title: const Text("Order History"),
              onTap: () {
                //Navigator.pushNamed(context, '/orders');
                Navigator.pushNamed(context, '/orderHistory');
              },
            ),
            const Divider(),

            // Help & Feedback
            ListTile(
              leading: const Icon(Icons.help_outline, color: Colors.brown),
              title: const Text("Help & Feedback"),
              onTap: () {
                Navigator.pushNamed(context, '/help');
              },
            ),
            const Divider(),

            // About
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.brown),
              title: const Text("About Alimudo Farms"),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: "Alimudo Farms",
                  applicationVersion: "1.0.0",
                  applicationLegalese: "© 2025 Alimudo Farms",
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Alimudo Farms connects you to fresh farm produce directly from the source. We promote sustainable agriculture and healthy living.",
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
