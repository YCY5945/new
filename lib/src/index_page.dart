
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:untitled/src/pages/common/protocol_model.dart';

import 'package:untitled/src/pages/common/user_helper.dart';

import 'package:untitled/src/utils/log_utils.dart';
import 'package:untitled/src/utils/sp_uitls.dart';
import 'package:untitled/src/welcome_page.dart';

import 'pages/common/permission_request_widget.dart';

import 'utils/navigator_utils.dart';

class IndexPage extends StatefulWidget   {
  const IndexPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _IndexPageState();
  }
}
class _IndexPageState extends State with ProtocolModel{


  final List<String> _list = [
    "为您更好的体验应用，所以需要获取您的手机文件存储权限，以保存您的一些偏好设置",
    "您已拒绝权限，所以无法保存您的一些偏好设置，将无法使用APP",
    "您已拒绝权限，请在设置中心中同意APP的权限请求",
    "其他错误"
  ];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/app_icon.png",
          width: 88,
          height: 88,
        ),
      ),
    );
  }

  void initData() async {
    bool isLog = !const bool.fromEnvironment("dart.vm.product");

    LogUtils.init(islog: isLog);

    LogUtils.e("权限申请");
    //权限申
    NavigatorUtils.pushPageByFade(
        context: context,
        targPage: PermissionRequestWidget(
          permission: Permission.camera,
          isCloseApp: false,
          permissionList: _list,
        ),
        dismissCallBack: (value) {
          LogUtils.e("权限申请结果 $value");

          initDataNext();
        });
  }
//初始化工具
  void initDataNext() async {
    //初始化
    await SPUtil.init();
    //读取一下标识
    bool? isAgrement = await SPUtil.getBool("isAgrement");

    LogUtils.e("isAgrement $isAgrement");

    UserHepler.getInstance.init();

    if (isAgrement == null || !isAgrement) {
      isAgrement = await showProtocolFunction(context);
    }

    if (isAgrement) {
      //同意
      LogUtils.e("同意协议");

      //保存一下标识
      SPUtil.save("isAgrement", true);


    } else {
      LogUtils.e("不同意");
      closeApp();
    }
  }

  void closeApp() {
    SystemChannels.platform.invokeMethod("SystemNavigator.pop");
  }

  void next() async {
    //判断是否第一次安装应用
    bool? isFirstInstall = await SPUtil.getBool("flutter_ho_isFirst");

    if (isFirstInstall == null) {
      //null 则是第一次安装应用
      //引导 页面
      NavigatorUtils.pushPageByFade(
          context: context, targPage: FirstGuildPage(), isReplace: true);
    } else {
      //倒计时页面
      NavigatorUtils.pushPageByFade(
          context: context, targPage: WelcomePage(), isReplace: true);
    }
  }
}




