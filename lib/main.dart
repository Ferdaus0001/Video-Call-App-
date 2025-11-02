// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
//
// import 'package:video_calling_app/vidoe_home_screen.dart';
// import 'package:zego_uikit/zego_uikit.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final navigatorKey = GlobalKey<NavigatorState>();
//
//   // Initialize Zego log
//   await ZegoUIKit().initLog();
//
//   runApp(MyApp(navigatorKey: navigatorKey));
// }
//
// class MyApp extends StatelessWidget {
//   final GlobalKey<NavigatorState> navigatorKey;
//
//   const MyApp({super.key, required this.navigatorKey});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       navigatorKey: navigatorKey,
//       debugShowCheckedModeBanner: false,
//       title: 'Video Calling App',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: VidoeHomeScreen(), // make sure your screen name matches
//     );
//   }
// }



// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'package:flutter/material.dart';
import 'package:video_calling_app/vidoe_home_screen.dart';
import 'package:zego_uikit/zego_uikit.dart';

import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final navigatorKey = GlobalKey<NavigatorState>();
  ZegoUIKit().initLog().then((value) {
    runApp(MyApp(navigatorKey: navigatorKey));
  });
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const MyApp({super.key, required this.navigatorKey});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: widget.navigatorKey,
      home: const HomeScreen(),
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            ZegoUIKitPrebuiltCallMiniOverlayPage(
              contextQuery: () {
                return widget.navigatorKey.currentState!.context;
              },
            ),
          ],
        );
      },
    );
  }
}




class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  final TextEditingController _callIdController = TextEditingController();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _callIdController.addListener(() {
      setState(() {
        isButtonEnabled = _callIdController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _callIdController.dispose();
    super.dispose();
  }

  void _shareCallID() {
    final callId = _callIdController.text.trim();
    if (callId.isNotEmpty) {
      Share.share("Join my video call using this Call ID: $callId");
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

            // Call button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isButtonEnabled
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CallingPage(
                        callID: _callIdController.text.trim(),
                      ),
                    ),
                  );
                }
                    : null, // 👈 button disabled when empty
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Call Now", style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 12),

            // Share button
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
