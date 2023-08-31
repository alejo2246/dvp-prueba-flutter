import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_dvp_prueba/domain/models/character_filters_model.dart';
import 'package:rick_morty_dvp_prueba/domain/models/character_model.dart';
import 'package:rick_morty_dvp_prueba/presentation/character/providers/character_provider.dart';
import 'package:rick_morty_dvp_prueba/presentation/character/screen/characters_screen.dart';
import 'package:rick_morty_dvp_prueba/presentation/character/widgets/character_item.dart';

class MockCharactersProvider extends ChangeNotifier
    implements CharactersProvider {
  @override
  String error = '';

  @override
  int currentPage = 1;

  @override
  int maxPages = 1;

  @override
  CharacterFilters filters = CharacterFilters();

  @override
  String searchQuery = "";
  
  @override
  List<CharacterModel> characters = [];

  @override
  Future<void> fetchCharacters() async {}

  @override
  void nextPage() {}

  @override
  void prevPage() {}

  @override
  void applyFiltersAndFetch() async {}

  @override
  void setSearchQuery(String q) {}

  @override
  void updateGenderFilter(String q) {}

  @override
  void updateSpeciesFilter(String q) {}

  @override
  void updateStatusFilter(String q) {}

  @override
  void updateTypeFilter(String q) {}
}

void main() {
  testWidgets('CharacterItemWidget displays character information',
      (WidgetTester tester) async {
    final character = CharacterModel(
      id: 0,
      name: 'Rick',
      image: 'https://example.com/rick.jpg',
      status: 'Alive',
      species: '',
      type: '',
      gender: '',
      originName: '',
      locationName: '',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: CharacterItemWidget(character: character),
      ),
    );

    expect(find.text('Rick'), findsOneWidget);

    expect(find.byType(CachedNetworkImage), findsOneWidget);

    expect(find.byIcon(Icons.brightness_1), findsOneWidget);
    expect(find.text('Alive'), findsOneWidget);

    final icon = tester.widget<Icon>(find.byIcon(Icons.brightness_1));
    final color = icon.color?.value;
    expect(color, const Color.fromARGB(255, 93, 213, 97).value);
  });

  testWidgets('CharacterScreen displays characters',
      (WidgetTester tester) async {
    final mockCharactersProvider = MockCharactersProvider();
    final characters = [
      CharacterModel(
        id: 0,
        name: 'Rick',
        image: 'rick.jpg',
        status: 'Alive',
        species: '',
        type: '',
        gender: '',
        originName: '',
        locationName: '',
      ),
      CharacterModel(
        id: 1,
        name: 'Morty',
        image: 'morty.jpg',
        status: 'Alive',
        species: '',
        type: '',
        gender: '',
        originName: '',
        locationName: '',
      ),
    ];
    mockCharactersProvider.characters = characters;

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<CharactersProvider>.value(
          value: mockCharactersProvider,
          child: const CharacterScreen(),
        ),
      ),
    );

    await tester.pump();

    expect(find.byType(CharacterItemWidget), findsNWidgets(2));
    expect(find.text('Rick'), findsOneWidget);
    expect(find.text('Morty'), findsOneWidget);
  });

  testWidgets('CharacterScreen displays empty list',
      (WidgetTester tester) async {
    final mockCharactersProvider = MockCharactersProvider();
    mockCharactersProvider.characters = [];

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<CharactersProvider>.value(
          value: mockCharactersProvider,
          child: const CharacterScreen(),
        ),
      ),
    );

    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('CharacterScreen displays error message',
      (WidgetTester tester) async {
    final mockCharactersProvider = MockCharactersProvider();
    mockCharactersProvider.error = 'Error fetching characters';

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<CharactersProvider>.value(
          value: mockCharactersProvider,
          child: const CharacterScreen(),
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Error fetching characters'), findsOneWidget);
  });
}
