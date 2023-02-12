import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';

class WebtoonCard extends StatelessWidget {
  const WebtoonCard({
    super.key,
    required this.webtoon,
  });

  final WebtoonModel webtoon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                    color: Colors.black.withOpacity(0.65)),
              ]),
          width: 240,
          child: Image.network(
            webtoon.thumb,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          webtoon.title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
