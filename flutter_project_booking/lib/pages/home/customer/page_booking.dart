import 'package:flutter/material.dart';

class PageBooking extends StatefulWidget {
  const PageBooking({super.key});

  @override
  State<PageBooking> createState() => _PageBookingState();
}

class _PageBookingState extends State<PageBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("PageBooking"),
      ),
    );
  }
}
