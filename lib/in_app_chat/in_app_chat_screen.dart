// in_app_chat_screen.dart
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import 'in_app_chat_screen.dart'; // conversation list page
class InAppChatScreen extends StatefulWidget {
  const InAppChatScreen({super.key});

  @override
  State<InAppChatScreen> createState() => _InAppChatScreenState();
}

class _InAppChatScreenState extends State<InAppChatScreen> {
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

  void _connectUser() async {
    final userName = _userNameController.text.trim();
    if (userName.isEmpty) return;

    final userID = "user_${userName}_${DateTime.now().millisecondsSinceEpoch}";

    try {
      await ZIMKit().connectUser(id: userID, name: userName);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ChatHomePage()),
      );
    } catch (e) {
      // যদি ZIMKit init না থাকে বা error আসে
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to connect user: $e")),
      );
    }
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

// Chat Home Page
class ChatHomePage extends StatelessWidget {
  const ChatHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Conversations")),
      body: ZIMKitConversationListView(
        onPressed: (context, conversation, defaultAction) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ZIMKitMessageListPage(
                conversationID: conversation.id,
                conversationType: conversation.type,
              ),
            ),
          );
        },
      ),
    );
  }
}
