import 'package:flutter/material.dart';

class CommonWebViewPage extends StatefulWidget {
  final String htmlUrl;
  final String pageTitle;


  const CommonWebViewPage({super.key, required this.htmlUrl, this.pageTitle = ""});

  @override
  _CommonWebViewPageState createState() => _CommonWebViewPageState();
}

class _CommonWebViewPageState extends State<CommonWebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle),
      ),
      backgroundColor: Colors.white,
      body: WebView(initialUrl:widget.htmlUrl),

    );
  }
}

WebView({required String initialUrl}) {
}



