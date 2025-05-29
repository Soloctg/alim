import 'package:flutter/material.dart';

class HelpFeedbackScreen extends StatefulWidget {
  const HelpFeedbackScreen({super.key});

  @override
  State<HelpFeedbackScreen> createState() => _HelpFeedbackScreenState();
}

class _HelpFeedbackScreenState extends State<HelpFeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      // Submit feedback logic (e.g. save to Firestore or send via email)
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Feedback submitted")));
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & Feedback"),
        backgroundColor: const Color.fromRGBO(138, 78, 47, 1),
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: ListView(
          children: [
            const Text(
              "Need Help?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "If you have any issues, suggestions, or questions, feel free to contact us or leave feedback below.",
            ),
            const SizedBox(height: 20),
            const Text(
              "Contact Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text("support@alimudo.com"),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text("+234 800 000 0000"),
            ),
            const Divider(height: 40),
            const Text(
              "Send Us Feedback",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _messageController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: "Type your message here...",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a message';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitFeedback,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(138, 78, 47, 1),
                foregroundColor: Colors.white,
              ),
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
