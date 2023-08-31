import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_dvp_prueba/presentation/episode/providers/episode_provider.dart';
import 'package:rick_morty_dvp_prueba/presentation/episode/screen/episode_detail_screen.dart';

class EpisodeScreen extends StatefulWidget {
  const EpisodeScreen({super.key});

  @override
  State<EpisodeScreen> createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends State<EpisodeScreen> {
  late EpisodeProvider _episodeProvider;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _episodeProvider = Provider.of<EpisodeProvider>(context, listen: false);
    _episodeProvider.fetchEpisodes();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Consumer<EpisodeProvider>(
        builder: (context, episodeProvider, _) {
          if (episodeProvider.error.isNotEmpty) {
            return Center(
              child: Text(episodeProvider.error),
            );
          }
          if (_isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search by name',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (query) {
                  episodeProvider.setSearchQuery(query);
                },
                controller:
                    TextEditingController(text: episodeProvider.searchQuery),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search by episode code',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (query) {
                  episodeProvider.setEpisodeQuery(query);
                },
                controller:
                    TextEditingController(text: episodeProvider.episodeQuery),
              ),
            ),
            if (episodeProvider.locations.isEmpty)
              const Expanded(
                child: Center(
                  child: Text("There is nothing here."),
                ),
              ),
            if (episodeProvider.locations.isNotEmpty)
              Expanded(
                  child: ListView.builder(
                controller: _scrollController,
                itemCount: episodeProvider.locations.length,
                itemBuilder: (context, index) {
                  final episode = episodeProvider.locations[index];
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EpisodeDetailsPage(episode: episode)),
                        );
                      },
                      child: Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(
                            episode.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            episode.episode,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 98, 98, 98),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ));
                },
              )),
            if (episodeProvider.locations.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        _episodeProvider.prevPage();
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
                    "page ${_episodeProvider.currentPage} of ${_episodeProvider.maxPages}",
                    style: const TextStyle(
                        fontFamily: "poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                      onPressed: () {
                        _episodeProvider.nextPage();
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
