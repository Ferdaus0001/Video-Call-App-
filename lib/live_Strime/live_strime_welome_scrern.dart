// live_srime_welcome_screen.dart
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'live_strieme_screen.dart';

class LiveSrimeWelcomScreen extends StatefulWidget {
  const LiveSrimeWelcomScreen({super.key});

  @override
  State<LiveSrimeWelcomScreen> createState() => _HomePageState();
}

class _HomePageState extends State<LiveSrimeWelcomScreen> {
  final TextEditingController _callIdController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController(); // নতুন ফিল্ড
  bool isButtonEnabled = false;
  bool isHost = true; // Host বা Audience toggle

  @override
  void initState() {
    super.initState();
    _callIdController.addListener(_updateButtonState);
    _userNameController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      // বাটন সক্রিয় হবে যদি Call ID এবং User Name দুইটিই দেওয়া থাকে
      isButtonEnabled = _callIdController.text.trim().isNotEmpty &&
          _userNameController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _callIdController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  void _shareCallID() {
    final callId = _callIdController.text.trim();
    if (callId.isNotEmpty) {
      Share.share("Join my live stream using this Call ID: $callId");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a Call ID to share")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // User Name field
            TextFormField(
              controller: _userNameController,
              decoration: InputDecoration(
                labelText: "Enter Your Name",
                hintText: "e.g. John Doe",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 12),

            // Call ID field
            TextFormField(
              controller: _callIdController,
              decoration: InputDecoration(
                labelText: "Enter Call ID",
                hintText: "e.g. 12345",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.videocam),
              ),
            ),
            const SizedBox(height: 20),

            // Start Live Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isButtonEnabled
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LiveStriemeScreen(
                        liveID: _callIdController.text.trim(),
                        userName: _userNameController.text.trim(), // Pass userName
                        isHost: isHost,
                      ),
                    ),
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Start Live", style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 12),

            // Share Call ID
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _shareCallID,
                icon: const Icon(Icons.share, color: Colors.deepPurple),
                label: const Text(
                  "Share Call ID",
                  style: TextStyle(color: Colors.deepPurple, fontSize: 16),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.deepPurple, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
