import 'package:flutter/material.dart';
import 'package:rick_morty_dvp_prueba/domain/models/location_model.dart';
import 'package:rick_morty_dvp_prueba/presentation/character/widgets/attributes_description_widget.dart';

class LocationDetailsPage extends StatelessWidget {
  final LocationModel location;
  const LocationDetailsPage({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          location.name,
          style: const TextStyle(
              fontFamily: 'poppins',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xff043c6e)),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DescriptionWidget(title: "Id", description: "${location.id}"),
              DescriptionWidget(title: "Type", description: location.type),
              DescriptionWidget(
                  title: "Dimension", description: location.dimension),
              DescriptionWidget(
                  title: "Created", description: location.created),
            ],
          ),
        ),
      ),
    );
  }
}
