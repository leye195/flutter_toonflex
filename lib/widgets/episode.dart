import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Episode extends StatelessWidget {
  const Episode({
    super.key,
    required this.webtoonId,
    required this.episode,
  });

  final String webtoonId;
  final WebtoonEpisodeModel episode;

  dynamic onTap(String id) {
    return () async {
      await launchUrlString(
          'https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=$id');
    };
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap(episode.id),
      child: Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black12))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Image.network(
                        episode.thumb,
                        width: 65,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(episode.title),
                            Row(
                              children: [
                                Text(
                                  episode.rating,
                                  style: const TextStyle(color: Colors.red),
                                ),
                                const SizedBox(width: 8),
                                Text(episode.date)
                              ],
                            )
                          ],
                        ))
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Colors.black)
            ],
          ),
        ),
      ),
    );
  }
}
