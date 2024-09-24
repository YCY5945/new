import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/src/welcome_time_widget.dart';
import 'package:untitled/src/welcome_video_widget.dart';

import 'home_page.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    //全屏展示
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              //第一层 背景 图片
              //视频播放
              Positioned.fill(
                child: Hero(
                  tag: "welcom1",
                  child: Material(
                    color: Colors.transparent,
                    child: WelcomeVideoWidget(),
                  ),
                ),
              ),
              //第二层 倒计时功能
              //右下角对齐
              Positioned(
                child: WelcomeTimeWidget(),
                right: 20,
                bottom: 66,
              )
            ],
          )),
    );
  }
}