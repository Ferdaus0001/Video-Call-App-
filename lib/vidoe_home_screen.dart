// ignore_for_file: depend_on_referenced_packages, unused_import, deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import 'app_const_info.dart';

class CallingPage extends StatefulWidget {
  const CallingPage({super.key, required this.callID});

  final String callID;

  @override
  State<CallingPage> createState() => _CallingPageState();
}

class _CallingPageState extends State<CallingPage> {
  late final String userId;

  @override
  void initState() {
    super.initState();
    // 👇 unique userID banega time-based
    userId = DateTime.now().millisecondsSinceEpoch.toString();

    if (kDebugMode) {
      print("🟢 Joining Call => callID: ${widget.callID}, userID: $userId");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: AppConstant.appId,
      appSign: AppConstant.appSinIn,
      userID: userId,
      userName: 'user_$userId',
      callID: widget.callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
      // 🔹 Join settings
        ..turnOnCameraWhenJoining = true
        ..turnOnMicrophoneWhenJoining = true
        ..useSpeakerWhenJoining = true           // Automatically use speaker
        // ..showUserJoinedLeaveToast = true        // Show toast on user join/leave
        // ..showSoundEffectButton = true           // Enable sound effect

      // 🔹 Top menu bar
        ..topMenuBar.isVisible = true
        ..topMenuBar.buttons = [
          ZegoCallMenuBarButtonName.minimizingButton,
          ZegoCallMenuBarButtonName.showMemberListButton,
          ZegoCallMenuBarButtonName.soundEffectButton,
          // ZegoCallMenuBarButtonName.settingsButton, // Opens in-call settings
        ]

      // 🔹 Bottom menu bar
        ..bottomMenuBarConfig = ZegoBottomMenuBarConfig(
          isVisible: true,
          margin: const EdgeInsets.only(bottom: 30),
          buttons: [
            ZegoCallMenuBarButtonName.toggleMicrophoneButton,
            ZegoCallMenuBarButtonName.toggleCameraButton,
            ZegoCallMenuBarButtonName.hangUpButton,
            ZegoCallMenuBarButtonName.chatButton,
            ZegoCallMenuBarButtonName.switchCameraButton,
            ZegoCallMenuBarButtonName.beautyEffectButton, // Skin/beauty effects
            // ZegoCallMenuBarButtonName.speakerButton,      // Toggle speaker
            // ZegoCallMenuBarButtonName.moreButton,         // Additional options
          ],
        )

      // 🔹 Other professional options
              // Use hardware encoder if possible
    );
  }
}