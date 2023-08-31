class LocationModel {
  final int id;
  final String name;
  final String type;
  final String dimension;
  final String created;
  final List<dynamic> residents;

  LocationModel({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
    required this.created,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'] ?? "Breed name",
      type: json['type'] ?? "unknown",
      dimension: json['dimension'] ?? "unknown",
      residents: json['residents'] ?? [],
      created: json['created'] ?? "",
    );
  }
}
