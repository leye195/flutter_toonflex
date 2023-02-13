class WebtoonEpisodeModel {
  final String id;
  final String title;
  final String rating;
  final String date;
  final String thumb;

  WebtoonEpisodeModel.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        date = json['date'],
        title = json['title'],
        thumb = json['thumb'],
        rating = json['rating'];
}
