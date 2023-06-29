import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Good Morning",
            style: TextStyle(fontSize: 30),
          ),
          Text("Explore the World with one Click")
        ],
      ),
    );
  }
}
