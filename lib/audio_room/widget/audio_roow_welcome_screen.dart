// audio_room_welcome_screen.dart
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_calling_app/audio_room/audio_room_screen.dart';

class AudioRoomWelcomeScreen extends StatefulWidget {
  const AudioRoomWelcomeScreen({super.key});

  @override
  State<AudioRoomWelcomeScreen> createState() => _AudioRoomWelcomeScreenState();
}

class _AudioRoomWelcomeScreenState extends State<AudioRoomWelcomeScreen> {
  final TextEditingController _roomIdController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  bool isButtonEnabled = false;
  bool isHost = true; // Host বা Audience toggle করতে পারবেন

  @override
  void initState() {
    super.initState();
    _roomIdController.addListener(_updateButtonState);
    _userNameController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = _roomIdController.text.trim().isNotEmpty &&
          _userNameController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _roomIdController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  void _shareRoomID() {
    final roomId = _roomIdController.text.trim();
    if (roomId.isNotEmpty) {
      Share.share("Join my audio room using this Room ID: $roomId");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a Room ID to share")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Audio Room"), centerTitle: true),
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

            // Room ID field
            TextFormField(
              controller: _roomIdController,
              decoration: InputDecoration(
                labelText: "Enter Room ID",
                hintText: "e.g. 12345",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.audiotrack),
              ),
            ),
            const SizedBox(height: 20),

            // Start Room Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isButtonEnabled
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LiveAudioRoomScreen(
                        roomID: _roomIdController.text.trim(),
                        userName: _userNameController.text.trim(),
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
                child: const Text("Join Room", style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 12),

            // Share Room Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _shareRoomID,
                icon: const Icon(Icons.share, color: Colors.deepPurple),
                label: const Text(
                  "Share Room ID",
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
