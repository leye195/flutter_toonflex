class WebtoonModel {
  final String title;
  final String id;
  final String thumb;

  WebtoonModel.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        thumb = json['thumb'];

  // WebtoonModel({required this.title, required this.id, required this.thumb});
}
