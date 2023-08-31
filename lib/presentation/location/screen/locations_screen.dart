import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_dvp_prueba/presentation/location/provider/location_provider.dart';
import 'package:rick_morty_dvp_prueba/presentation/location/screen/location_detail_screen.dart';
import 'package:rick_morty_dvp_prueba/presentation/location/widgets/locations_filter_modal.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

void _showFilterDialog(BuildContext context, LocationProvider chProv) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return LocationFilterModal(
        selectedDimension: chProv.dimensionQuery,
        selectedType: chProv.typeQuery,
        onApplyFilters: (dimension, type) {
          chProv.setDimensionQuery(dimension);
          chProv.setTypeQuery(type);
          chProv.applyFiltersAndFetch();
          Navigator.pop(context);
        },
      );
    },
  );
}

class _LocationScreenState extends State<LocationScreen> {
  late LocationProvider _locationProvider;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _locationProvider = Provider.of<LocationProvider>(context, listen: false);
    _locationProvider.fetchLocations();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Consumer<LocationProvider>(
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
            if (characterProvider.locations.isEmpty)
              const Expanded(
                child: Center(
                  child: Text("There is nothing here."),
                ),
              ),
            if (characterProvider.locations.isNotEmpty)
              Expanded(
                  child: ListView.builder(
                controller: _scrollController,
                itemCount: characterProvider.locations.length,
                itemBuilder: (context, index) {
                  final location = characterProvider.locations[index];
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LocationDetailsPage(location: location)),
                        );
                      },
                      child: Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(
                            location.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            location.type,
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
            if (characterProvider.locations.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        _locationProvider.prevPage();
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
                    "page ${_locationProvider.currentPage} of ${_locationProvider.maxPages}",
                    style: const TextStyle(
                        fontFamily: "poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                      onPressed: () {
                        _locationProvider.nextPage();
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
