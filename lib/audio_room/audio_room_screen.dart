
import 'package:video_calling_app/app_const_info.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';
import 'package:flutter/material.dart';
class LiveAudioRoomScreen extends StatelessWidget {
  final String roomID;
  final bool isHost;
  final String userName;

  const LiveAudioRoomScreen({Key? key, required this.roomID, this.isHost = false, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveAudioRoom(
        appID: AppConstant.appId, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign: AppConstant.appSinIn, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: 'user_id',
        userName: 'user_name',
        roomID: roomID,
        config: isHost
            ? ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
            : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience(),
      ),
    );
  }
}