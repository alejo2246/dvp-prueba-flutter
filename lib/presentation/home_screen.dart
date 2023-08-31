import 'package:flutter/material.dart';
import 'package:rick_morty_dvp_prueba/presentation/character/screen/characters_screen.dart';
import 'package:rick_morty_dvp_prueba/presentation/episode/screen/episodes_screen.dart';
import 'package:rick_morty_dvp_prueba/presentation/location/screen/locations_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _pages = <Widget>[
    const CharacterScreen(),
    const EpisodeScreen(),
    const LocationScreen()
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rick and Morty APP',
          style: TextStyle(
              fontFamily: 'poppins',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xff043c6e)),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color(0xFFA6CCCC),
        centerTitle: true,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person_3),
              label: 'Characters',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Episodes'),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on), label: 'Locations'),
          ]),
    );
  }
}
