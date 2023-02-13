import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String id;
  final String title;
  final String thumb;

  const DetailScreen(
      {super.key, required this.id, required this.title, required this.thumb});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
    );
  }
}
