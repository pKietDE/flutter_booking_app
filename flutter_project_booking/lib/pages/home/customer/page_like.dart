import 'package:flutter/material.dart';

class PageLike extends StatefulWidget {
  const PageLike({super.key});

  @override
  State<PageLike> createState() => _PageLikeState();
}

class _PageLikeState extends State<PageLike> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("PageLike"),
      ),
    );
  }
}
