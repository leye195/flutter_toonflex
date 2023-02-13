import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  late SharedPreferences pref;
  bool isLiked = false;

  Future intializePref() async {
    pref = await SharedPreferences.getInstance();
    final likedToons = pref.getStringList('likedToons');

    if (likedToons != null && likedToons.contains(widget.id) == true) {
      setState(() {
        isLiked = true;
      });
      return;
    }

    pref.setStringList('likedToons', []);
  }

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getEpisodesById(widget.id);
    intializePref();
  }

  void onTabFavourite() async {
    final likedToons = pref.getStringList('likedToons');

    if (likedToons!.contains(widget.id)) {
      likedToons.remove(widget.id);
      isLiked = false;
    } else {
      likedToons.add(widget.id);
      isLiked = true;
    }

    await pref.setStringList('likedToons', likedToons);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text(widget.title,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      shadows: [
                        Shadow(
                          blurRadius: innerBoxIsScrolled ? 0 : 10.0,
                          color: Colors.black,
                        )
                      ])),
              actions: [
                IconButton(
                  icon: Icon(isLiked == true
                      ? Icons.favorite
                      : Icons.favorite_border_outlined),
                  onPressed: onTabFavourite,
                )
              ],
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
