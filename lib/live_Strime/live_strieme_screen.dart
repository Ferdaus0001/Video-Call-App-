// live_strieme_screen.dart
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';
import '../app_const_info.dart';

class LiveStriemeScreen extends StatefulWidget {
  final String liveID;
  final String userName; // নতুন ফিল্ড
  final bool isHost;

  const LiveStriemeScreen({
    super.key,
    required this.liveID,
    required this.userName,
    required this.isHost,
  });

  @override
  State<LiveStriemeScreen> createState() => _LiveStriemeScreenState();
}

class _LiveStriemeScreenState extends State<LiveStriemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ZegoUIKitPrebuiltLiveStreaming(
          appID: AppConstant.appId,
          appSign: AppConstant.appSinIn,
          userID: widget.userName, // এখানে userName ব্যবহার হচ্ছে userID হিসেবে
          userName: widget.userName,
          liveID: widget.liveID,
          config: widget.isHost
              ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
              : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
        ),
      ),
    );
  }
}
