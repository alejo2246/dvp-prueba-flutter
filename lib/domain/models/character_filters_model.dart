class CharacterFilters {
  final String status;
  final String species;
  final String type;
  final String gender;

  CharacterFilters({
    this.status = '',
    this.species = '',
    this.type = '',
    this.gender = '',
  });

  CharacterFilters copyWith({
    String? status,
    String? species,
    String? type,
    String? gender,
  }) {
    return CharacterFilters(
      status: status ?? this.status,
      species: species ?? this.species,
      type: type ?? this.type,
      gender: gender ?? this.gender,
    );
  }
}
