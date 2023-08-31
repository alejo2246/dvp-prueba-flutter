import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty_dvp_prueba/domain/models/character_model.dart';
import 'package:rick_morty_dvp_prueba/presentation/character/widgets/attributes_description_widget.dart';

class CharacterDetailsPage extends StatelessWidget {
  final CharacterModel character;
  const CharacterDetailsPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          character.name,
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
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: character.image,
                    placeholder: (context, url) =>
                        Image.asset("assets/images/image_placeholder.png"),
                    errorWidget: (context, url, error) =>
                        Image.asset("assets/images/image_placeholder.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DescriptionWidget(
                          title: "Id", description: "${character.id}"),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Status:',
                            style: TextStyle(
                              fontFamily: "poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.brightness_1,
                                size: 16,
                                color: character.status == "Alive"
                                    ? const Color.fromARGB(255, 93, 213, 97)
                                    : const Color.fromARGB(255, 215, 56, 45),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                character.status,
                                style: const TextStyle(
                                  fontFamily: "poppins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 45, 45, 45),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      DescriptionWidget(
                          title: "Origin", description: character.originName),
                      DescriptionWidget(
                          title: "Type", description: character.type),
                      DescriptionWidget(
                          title: "Gender", description: character.gender),
                      DescriptionWidget(
                          title: "Species", description: character.species),
                      DescriptionWidget(
                          title: "Location ",
                          description: character.locationName),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
