// in_app_chat_welcome_screen.dart
import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import 'in_app_chat_screen.dart'; // conversation list page

class InAppChatWelcomeScreen extends StatefulWidget {
  const InAppChatWelcomeScreen({super.key});

  @override
  State<InAppChatWelcomeScreen> createState() => _InAppChatWelcomeScreenState();
}

class _InAppChatWelcomeScreenState extends State<InAppChatWelcomeScreen> {
  final TextEditingController _userNameController = TextEditingController();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _userNameController.addListener(() {
      setState(() {
        isButtonEnabled = _userNameController.text.trim().isNotEmpty;
      });
    });
  }

  void _connectUser() {
    final userName = _userNameController.text.trim();
    if (userName.isEmpty) return;

    ZIMKit().connectUser(id: userName, name: userName).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const InAppChatScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("In-App Chat")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _userNameController,
              decoration: const InputDecoration(
                labelText: "Enter your name",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isButtonEnabled ? _connectUser : null,
                child: const Text("Connect"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
