import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_dvp_prueba/presentation/character/providers/character_provider.dart';
import 'package:rick_morty_dvp_prueba/presentation/character/widgets/character_filters.dart';
import 'package:rick_morty_dvp_prueba/presentation/character/widgets/character_item.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

void _showFilterDialog(BuildContext context, CharactersProvider chProv) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CharacterFilterModal(
        selectedSpecies: chProv.filters.species,
        selectedStatus: chProv.filters.status,
        selectedGender: chProv.filters.gender,
        selectedType: chProv.filters.type,
        onApplyFilters: (status, species, gender, type) {
          chProv.updateSpeciesFilter(species);
          chProv.updateStatusFilter(status);
          chProv.updateGenderFilter(gender);
          chProv.updateTypeFilter(type);
          chProv.applyFiltersAndFetch();
          Navigator.pop(context);
        },
      );
    },
  );
}

class _CharacterScreenState extends State<CharacterScreen> {
  late CharactersProvider _charactersProvider;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _charactersProvider =
        Provider.of<CharactersProvider>(context, listen: false);
    _charactersProvider.fetchCharacters();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Consumer<CharactersProvider>(
        builder: (context, characterProvider, _) {
          if (characterProvider.error.isNotEmpty) {
            return Center(
              child: Text(characterProvider.error),
            );
          }
          if (_isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (query) {
                        characterProvider.setSearchQuery(query);
                      },
                      controller: TextEditingController(
                          text: characterProvider.searchQuery),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.list_rounded,
                      size: 30,
                      color: Color(0xFF043C6E),
                    ),
                    onPressed: () {
                      _showFilterDialog(context, characterProvider);
                    },
                  ),
                ],
              ),
            ),
            if (characterProvider.characters.isEmpty)
              const Expanded(
                child: Center(
                  child: Text("There is nothing here."),
                ),
              ),
            if (characterProvider.characters.isNotEmpty)
              Expanded(
                  child: ListView.builder(
                controller: _scrollController,
                itemCount: characterProvider.characters.length,
                itemBuilder: (context, index) {
                  final character = characterProvider.characters[index];
                  return CharacterItemWidget(character: character);
                },
              )),
            if (characterProvider.characters.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        _charactersProvider.prevPage();
                        _scrollController.animateTo(0,
                            duration: const Duration(milliseconds: 650),
                            curve: Curves.easeInOut);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF043C6E),
                      )),
                  const SizedBox(width: 10),
                  Text(
                    "page ${_charactersProvider.currentPage} of ${_charactersProvider.maxPages}",
                    style: const TextStyle(
                        fontFamily: "poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                      onPressed: () {
                        _charactersProvider.nextPage();
                        _scrollController.animateTo(0,
                            duration: const Duration(milliseconds: 650),
                            curve: Curves.easeInOut);
                      },
                      icon: const Icon(
                        Icons.arrow_forward_rounded,
                        color: Color(0xFF043C6E),
                      )),
                ],
              ),
          ]);
        },
      ),
    );
  }
}
