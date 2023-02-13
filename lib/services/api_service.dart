import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  static const baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = '/today';

  // future (async await)
  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl$today');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);

      for (var webtoon in webtoons) {
        final toon = WebtoonModel.fromJSON(webtoon);
        webtoonInstances.add(toon);
      }

      return webtoonInstances;
    }

    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final webtoonDetailInstance =
          WebtoonDetailModel.fromJSON(jsonDecode(response.body));
      return webtoonDetailInstance;
    }

    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getEpisodesById(String id) async {
    List<WebtoonEpisodeModel> episodeInstances = [];

    final url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> episodes = jsonDecode(response.body);

      for (var episode in episodes) {
        final episodeInstance = WebtoonEpisodeModel.fromJSON(episode);
        episodeInstances.add(episodeInstance);
      }

      return episodeInstances;
    }

    throw Error();
  }
}
