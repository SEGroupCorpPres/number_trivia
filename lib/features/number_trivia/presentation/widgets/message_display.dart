import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(message, style: TextStyle(fontSize: 30), textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
