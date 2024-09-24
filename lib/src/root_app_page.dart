import 'package:flutter/material.dart';


class RootAPP extends StatefulWidget {
  const RootAPP({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RootAPPState();
  }
}

class _RootAPPState extends State {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.lightBlueAccent,
          bottomAppBarTheme: const BottomAppBarTheme(color: Colors.blue)),
      //不显示 debug 标签
      debugShowCheckedModeBanner: false,

      // home: IndexPage(),
    );
  }
}
