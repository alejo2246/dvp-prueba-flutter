import 'package:flutter/material.dart';
import 'package:rick_morty_dvp_prueba/domain/models/episode_model.dart';
import 'package:rick_morty_dvp_prueba/presentation/character/widgets/attributes_description_widget.dart';

class EpisodeDetailsPage extends StatelessWidget {
  final EpisodeModel episode;
  const EpisodeDetailsPage({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          episode.name,
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
              DescriptionWidget(title: "Id", description: "${episode.id}"),
              DescriptionWidget(
                  title: "Air Date", description: episode.airDate),
              DescriptionWidget(title: "Episode", description: episode.episode),
              DescriptionWidget(title: "Created", description: episode.created),
            ],
          ),
        ),
      ),
    );
  }
}
