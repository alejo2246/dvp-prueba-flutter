import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_dvp_prueba/presentation/character/providers/character_provider.dart';
import 'package:rick_morty_dvp_prueba/presentation/episode/providers/episode_provider.dart';
import 'package:rick_morty_dvp_prueba/presentation/location/provider/location_provider.dart';
import 'package:rick_morty_dvp_prueba/presentation/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CharactersProvider()),
          ChangeNotifierProvider(create: (context) => LocationProvider()),
          ChangeNotifierProvider(create: (context) => EpisodeProvider()),
        ],
        child: MaterialApp(
          title: 'Rick and Mory App',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFFA6CCCC)),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        ));
  }
}
