import 'package:flutter/material.dart';

typedef ApplyFiltersCallback = void Function(
    String status, String species, String gender, String type);

class CharacterFilterModal extends StatefulWidget {
  final ApplyFiltersCallback onApplyFilters;
  final String selectedStatus;
  final String selectedSpecies;
  final String selectedType;
  final String selectedGender;

  const CharacterFilterModal({
    Key? key,
    required this.selectedStatus,
    required this.selectedSpecies,
    required this.selectedType,
    required this.onApplyFilters,
    required this.selectedGender,
  }) : super(key: key);

  @override
  CharacterFilterModalState createState() => CharacterFilterModalState();
}

class CharacterFilterModalState extends State<CharacterFilterModal> {
  late String _selectedStatus;
  late String _selectedSpecies;
  late String _selectedType;
  late String _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.selectedStatus;
    _selectedSpecies = widget.selectedSpecies;
    _selectedType = widget.selectedType;
    _selectedGender = widget.selectedGender;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Apply Filters'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Status',
              style: TextStyle(
                  fontFamily: "poppins",
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _selectedStatus,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedStatus = value;
                  });
                }
              },
              items: ['alive', 'dead', 'unknown', ''].map((status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status.isNotEmpty ? status : 'All'),
                );
              }).toList(),
            ),
          ]),
        ),
        Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Specie',
                style: TextStyle(
                    fontFamily: "poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: _selectedSpecies,
                hint: const Text('Species'),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedSpecies = value;
                    });
                  }
                },
                items: ['Human', 'Alien', ''].map((species) {
                  return DropdownMenuItem<String>(
                    value: species,
                    child: Text(species.isNotEmpty ? species : 'All'),
                  );
                }).toList(),
              ),
            ])),
        Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Type',
                style: TextStyle(
                    fontFamily: "poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: _selectedType,
                hint: const Text('Type'),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedType = value;
                    });
                  }
                },
                items: [
                  'Superhuman',
                  'Parasite',
                  'Genetic experiment',
                  'Human with antennae',
                  'Human with ants in his eyes',
                  ''
                ].map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type.isNotEmpty ? type : 'All'),
                  );
                }).toList(),
              ),
            ])),
        Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Gender',
                style: TextStyle(
                    fontFamily: "poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: _selectedGender,
                hint: const Text('Gender'),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedGender = value;
                    });
                  }
                },
                items: ['female', 'male', 'genderless', 'unknown', '']
                    .map((gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender.isNotEmpty ? gender : 'All'),
                  );
                }).toList(),
              ),
            ])),
      ]),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget.onApplyFilters(_selectedStatus, _selectedSpecies,
                _selectedGender, _selectedType);
          },
          child: const Text('Apply Filters'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
