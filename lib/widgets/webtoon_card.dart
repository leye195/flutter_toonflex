import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/routes/slide_route.dart';
import 'package:toonflix/screens/detail_screen.dart';
import 'package:toonflix/widgets/webtoon_image.dart';

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
            direction: 'top',
            page: DetailScreen(
              id: webtoon.id,
              title: webtoon.title,
              thumb: webtoon.thumb,
            )),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab(context),
      child: Column(
        children: [
          WebtoonImage(thumb: webtoon.thumb),
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
