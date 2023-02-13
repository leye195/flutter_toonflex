import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/routes/slide_route.dart';
import 'package:toonflix/screens/detail_screen.dart';

class WebtoonCard extends StatelessWidget {
  const WebtoonCard({
    super.key,
    required this.webtoon,
  });

  final WebtoonModel webtoon;

  dynamic onTab(BuildContext context) {
    return () {
      Navigator.push(
          context,
          SlideRoute(
              page: DetailScreen(
            id: webtoon.id,
            title: webtoon.title,
            thumb: webtoon.thumb,
          )));
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab(context),
      child: Column(
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
      ),
    );
  }
}
