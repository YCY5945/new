import 'package:flutter/cupertino.dart';
import 'package:untitled/src/utils/log_utils.dart';
import 'package:video_player/video_player.dart';

class WelcomeVideoWidget extends StatefulWidget {
  @override
  _WelcomeVideoWidgetState createState() => _WelcomeVideoWidgetState();
}

class _WelcomeVideoWidgetState extends State<WelcomeVideoWidget> {
  //创建视频播放控制器
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/video/welcom.mp4')
      ..initialize().then((_) {
        LogUtils.e("加载完成");
        _controller.play();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      ),
    )
        : Container();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}