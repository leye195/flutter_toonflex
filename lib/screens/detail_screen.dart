import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/episode.dart';
import 'package:toonflix/widgets/webtoon_image.dart';

class DetailScreen extends StatefulWidget {
  final String id;
  final String title;
  final String thumb;

  const DetailScreen(
      {super.key, required this.id, required this.title, required this.thumb});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getEpisodesById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text(widget.title,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      shadows: [
                        Shadow(
                          color: Colors.black45,
                        )
                      ])),
              foregroundColor: innerBoxIsScrolled ? Colors.green : Colors.white,
              backgroundColor: Colors.white,
              elevation: 0.5,
              expandedHeight: 200,
              pinned: true,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                background: WebtoonImage(
                  id: '${widget.id}-thumbnail',
                  thumb: widget.thumb,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WebtoonImage(id: widget.id, thumb: widget.thumb),
                ],
              ),
              const SizedBox(height: 16),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(snapshot.data!.title,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                              '${snapshot.data!.genre} / ${snapshot.data!.age}',
                              style: const TextStyle(fontSize: 18)),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            snapshot.data!.about,
                            style: const TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    );
                  }
                  return const Text('...');
                },
              ),
              const SizedBox(height: 16),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 42, vertical: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (var episode in snapshot.data!)
                            Episode(
                              episode: episode,
                              webtoonId: widget.id,
                            ),
                        ],
                      ),
                    );
                  }

                  return Container();
                },
              )
            ]),
          ),
        ),
      ),
    );
  }
}
