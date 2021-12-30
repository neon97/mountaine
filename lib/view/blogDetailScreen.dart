import 'dart:async';

import 'package:flutter/material.dart';

class BlogDetailPage extends StatefulWidget {
  final String mountName;
  BlogDetailPage({required this.mountName});
  @override
  _BlogDetailPageState createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {}, child: Text(widget.mountName)),
      ),
    );
  }
}
