class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String originName;
  final String locationName;
  final String image;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.originName,
    required this.locationName,
    required this.image,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'] ?? "Character name",
      status: json['status'] ?? "Unknown",
      species: json['species'] ?? "Unknown",
      type: json['type'] ?? "Unknown",
      gender: json['gender'] ?? "Unknown",
      originName: json['origin']['name'] ?? "Unknown",
      locationName: json['location']['name'] ?? "Unknown",
      image: json['image'] ??
          "https://rickandmortyapi.com/api/character/avatar/361.jpeg",
    );
  }
}
