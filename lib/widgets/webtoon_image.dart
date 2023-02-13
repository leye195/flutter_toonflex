import 'package:flutter/material.dart';

class WebtoonImage extends StatelessWidget {
  const WebtoonImage({
    super.key,
    required this.id,
    required this.thumb,
  });

  final String id;
  final String thumb;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: id,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
          BoxShadow(
              blurRadius: 12,
              offset: const Offset(0, 5),
              color: Colors.black.withOpacity(0.65)),
        ]),
        width: 240,
        child: Image.network(
          thumb,
        ),
      ),
    );
  }
}
