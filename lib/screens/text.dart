import 'package:flutter/material.dart';

class TextSection extends StatelessWidget {
  
  final String description;

  const TextSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Text(
          description,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}