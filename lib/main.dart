// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
//
// import 'package:video_calling_app/vidoe_call_home_screen.dart';
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




import 'package:flutter/material.dart';


import 'package:zego_uikit/zego_uikit.dart';

import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import 'audio_room/widget/audio_roow_welcome_screen.dart';


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
      home: const AudioRoomWelcomeScreen(),
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

