import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rick_morty_dvp_prueba/data/services/api_service.dart';
import 'package:rick_morty_dvp_prueba/domain/models/character_filters_model.dart';
import 'package:rick_morty_dvp_prueba/domain/models/character_model.dart';

class CharactersProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  String _error = '';
  int _maxPages = 1;
  int _currentPage = 1;
  List<CharacterModel> _characters = [];
  CharacterFilters _filters = CharacterFilters();
  String _searchQuery = "";

  String get searchQuery => _searchQuery;
  String get error => _error;
  List<CharacterModel> get characters => _characters;
  int get maxPages => _maxPages;
  int get currentPage => _currentPage;
  CharacterFilters get filters => _filters;

  void updateStatusFilter(String status) {
    _filters = _filters.copyWith(status: status);
  }

  void updateSpeciesFilter(String species) {
    _filters = _filters.copyWith(species: species);
  }

  void updateTypeFilter(String type) {
    _filters = _filters.copyWith(type: type);
  }

  void updateGenderFilter(String gender) {
    _filters = _filters.copyWith(gender: gender);
  }

  void applyFiltersAndFetch() {
    _currentPage = 1;
    fetchCharacters();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _currentPage = 1;
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    try {
      String queryParams = "?page=$_currentPage";
      if (_searchQuery.isNotEmpty) {
        queryParams += "&name=$_searchQuery";
      }

      if (_filters.status.isNotEmpty) {
        queryParams += "&status=${_filters.status}";
      }

      if (_filters.species.isNotEmpty) {
        queryParams += "&species=${_filters.species}";
      }

      if (_filters.type.isNotEmpty) {
        queryParams += "&type=${_filters.type}";
      }

      if (_filters.gender.isNotEmpty) {
        queryParams += "&gender=${_filters.gender}";
      }
      final response = await _apiService.getData("character", queryParams);

      if (response.statusCode != 200 && response.statusCode != 404) {
        _error = 'Error fetching characters';
        notifyListeners();
        return;
      }

      if (response.statusCode == 404) {
        _characters = [];
        notifyListeners();
        return;
      }
      final data = json.decode(response.body);
      _maxPages = data["info"]?["pages"] ?? 1;
      List<CharacterModel> charactersList = List<CharacterModel>.from(
          data["results"].map((json) => CharacterModel.fromJson(json)));
      _error = '';
      _characters = charactersList;
      notifyListeners();
    } catch (error) {
      _error = 'An error has occurred';
      notifyListeners();
    }
  }

  void nextPage() {
    if (_currentPage < _maxPages) {
      _currentPage++;
      fetchCharacters();
    }
  }

  void prevPage() {
    if (_currentPage > 1) {
      _currentPage--;
      fetchCharacters();
    }
  }
}
