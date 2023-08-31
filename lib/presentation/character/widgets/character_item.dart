import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty_dvp_prueba/domain/models/character_model.dart';
import 'package:rick_morty_dvp_prueba/presentation/character/screen/character_detail_screen.dart';

class CharacterItemWidget extends StatefulWidget {
  final CharacterModel character;
  const CharacterItemWidget({super.key, required this.character});

  @override
  State<CharacterItemWidget> createState() => _CharacterItemWidgetState();
}

class _CharacterItemWidgetState extends State<CharacterItemWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CharacterDetailsPage(character: widget.character)),
          );
        },
        child: Card(
          margin: EdgeInsets.all(screenWidth * 0.03),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: CachedNetworkImage(
                    imageUrl: widget.character.image,
                    placeholder: (context, url) => Image.asset(
                      "assets/images/image_placeholder.png",
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/images/image_placeholder.png",
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      widget.character.name,
                      style: const TextStyle(
                          fontFamily: "poppins",
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.brightness_1,
                          size: 16,
                          color: widget.character.status == "Alive"
                              ? const Color.fromARGB(255, 93, 213, 97)
                              : const Color.fromARGB(255, 215, 56, 45),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.character.status,
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
              ),
            ],
          ),
        ));
  }
}
