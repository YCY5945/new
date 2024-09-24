import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {runApp(
  MaterialApp(
    home: BobbleLoginPage(),
    
  )
);}
///气泡登陆页面
class BobbleLoginPage extends StatefulWidget {
  @override
  _BobbleLoginPageState createState() => _BobbleLoginPageState();
}

class _BobbleLoginPageState extends State<BobbleLoginPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
            children: []
        ),
      ),


    );
  }
  }













