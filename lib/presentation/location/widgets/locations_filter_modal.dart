import 'package:flutter/material.dart';

typedef ApplyFiltersCallback = void Function(String dimension, String type);

class LocationFilterModal extends StatefulWidget {
  final ApplyFiltersCallback onApplyFilters;
  final String selectedType;
  final String selectedDimension;

  const LocationFilterModal({
    Key? key,
    required this.selectedDimension,
    required this.selectedType,
    required this.onApplyFilters,
  }) : super(key: key);

  @override
  LocationFilterModalState createState() => LocationFilterModalState();
}

class LocationFilterModalState extends State<LocationFilterModal> {
  late String _selectedDimension;
  late String _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedDimension = widget.selectedDimension;
    _selectedType = widget.selectedType;
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
              'Dimension',
              style: TextStyle(
                  fontFamily: "poppins",
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _selectedDimension,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedDimension = value;
                  });
                }
              },
              items: [
                "Testicle Monster Dimension",
                "Dimension C-137",
                "Cromulon Dimension",
                "Dimension C-500A",
                "Replacement Dimension",
                "Evil Rick's Target Dimension",
                "Post-Apocalyptic Dimension",
                "Cronenberg Dimension",
                "Fantasy Dimension",
                "Dimension 5-126",
                "unknown",
                ''
              ].map((dimension) {
                return DropdownMenuItem<String>(
                  value: dimension,
                  child: Text(dimension.isNotEmpty ? dimension : 'All'),
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
                  'Planet',
                  'Cluster',
                  'Space station',
                  'Microverse',
                  'TV',
                  "Resort",
                  "Fantasy town",
                  "Dream",
                  "Menagerie",
                  "Game",
                  "Customs",
                  "Dimension",
                  ''
                ].map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type.isNotEmpty ? type : 'All'),
                  );
                }).toList(),
              ),
            ])),
      ]),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget.onApplyFilters(
              _selectedDimension,
              _selectedType,
            );
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
