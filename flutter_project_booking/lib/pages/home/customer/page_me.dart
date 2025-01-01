import 'package:flutter/material.dart';

class PageMe extends StatefulWidget {
  const PageMe({super.key});

  @override
  State<PageMe> createState() => _PageMeState();
}

class _PageMeState extends State<PageMe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("PageMe"),
      ),
    );
  }
}
