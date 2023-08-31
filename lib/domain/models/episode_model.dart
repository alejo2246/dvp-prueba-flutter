class EpisodeModel {
  final int id;
  final String name;
  final String airDate;
  final String episode;
  final String created;
  final List<dynamic> characters;

  EpisodeModel({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.created,
    required this.characters,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'],
      name: json['name'] ?? "Breed name",
      airDate: json['air_date'] ?? "unknown",
      episode: json['episode'] ?? "unknown",
      characters: json['characters'] ?? [],
      created: json['created'] ?? "",
    );
  }
}
