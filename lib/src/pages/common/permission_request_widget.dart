import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionRequestWidget extends StatefulWidget {
  final Permission permission;
  final List<String> permissionList;
  final bool isCloseApp;
  final String leftButtonText;

  const PermissionRequestWidget(
      {super.key, required this.permission,
      required this.permissionList,
      this.leftButtonText = "再考虑一下",
      this.isCloseApp = false});

  @override
  _PermissionRequestWidgetState createState() =>
      _PermissionRequestWidgetState();
}

class _PermissionRequestWidgetState extends State<PermissionRequestWidget>
    with WidgetsBindingObserver {
  //页面的初始化函数
  @override
  void initState() {
    super.initState();
    checkPermisson();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed && _isGoSetting) {
      checkPermisson();
    }
  }

  void checkPermisson({PermissionStatus? status}) async {
    //权限
    Permission permission = widget.permission;

    status ??= await permission.status;

    if (status.isGranted) {
      Navigator.of(context).pop(true);
    } else if (status.isLimited) {
      showPermissonAlert(widget.permissionList[0], "同意", permission);
    }
    if (status.isDenied) {
      {
        showPermissonAlert(widget.permissionList[2], "去设置中心", permission,
            isSetting: true);
        return;
      }
    } else if (status.isPermanentlyDenied) {
      showPermissonAlert(widget.permissionList[2], "去设置中心", permission,
          isSetting: true);
    } else {
      Navigator.of(context).pop(true);
    }
  }

  bool _isGoSetting = false;

  void showPermissonAlert(
      String message, String rightString, Permission permission,
      {bool isSetting = false}) async {
    dynamic result = await showCupertinoDialog(
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text("温馨提示"),
            content: Container(
              padding: const EdgeInsets.all(12),
              child: Text(message),
            ),
            actions: [
              //左边的按钮
              CupertinoDialogAction(
                child: Text(widget.leftButtonText),
                onPressed: () {
                  if (widget.isCloseApp) {
                    closeApp();
                  } else {
                    Navigator.of(context).pop(false);
                  }
                },
              ),
              //右边的按钮
              CupertinoDialogAction(
                child: Text(rightString),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (isSetting) {
                    _isGoSetting = true;
                    //去设置中心
                    openAppSettings();
                  } else {
                    //申请权限
                    requestPermiss(permission);
                  }
                },
              )
            ],
          );
        },
        context: context);

    if (result != null && !result) {
      Navigator.of(context).pop();
    }
  }

  void requestPermiss(Permission permission) async {
    //发起权限申请
    PermissionStatus status = await permission.request();
    //校验
    checkPermisson();
  }

  void closeApp() {
    //关闭应用的方法okeMethod("SystemNavigator.pop");
    //   }
    SystemChannels.platform.invokeMethod("SystemNavigator.pop");
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
    );
  }

  @override
  void dispose() {
    //注销观察者
    WidgetsBinding.instance.removeObserver(this);
  
    super.dispose();
  }
}
