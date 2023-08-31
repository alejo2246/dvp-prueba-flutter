import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rick_morty_dvp_prueba/data/services/api_service.dart';
import 'package:rick_morty_dvp_prueba/domain/models/episode_model.dart';

class EpisodeProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  String _error = '';
  int _maxPages = 1;
  int _currentPage = 1;
  List<EpisodeModel> _locations = [];
  String _episodeQuery = '';
  String _searchQuery = "";

  String get searchQuery => _searchQuery;
  String get episodeQuery => _episodeQuery;
  String get error => _error;
  List<EpisodeModel> get locations => _locations;
  int get maxPages => _maxPages;
  int get currentPage => _currentPage;

  void setEpisodeQuery(String code) {
    _episodeQuery = code;
    _currentPage = 1;
    fetchEpisodes();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _currentPage = 1;
    fetchEpisodes();
  }

  Future<void> fetchEpisodes() async {
    try {
      String queryParams = "?page=$_currentPage";
      if (_searchQuery.isNotEmpty) {
        queryParams += "&name=$_searchQuery";
      }

      if (_episodeQuery.isNotEmpty) {
        queryParams += "&episode=$_episodeQuery";
      }

      final response = await _apiService.getData("episode", queryParams);

      if (response.statusCode != 200 && response.statusCode != 404) {
        _error = 'Error fetching locations';
        notifyListeners();
        return;
      }

      if (response.statusCode == 404) {
        _locations = [];
        notifyListeners();
        return;
      }
      final data = json.decode(response.body);
      _maxPages = data["info"]?["pages"] ?? 1;
      List<EpisodeModel> episodesList = List<EpisodeModel>.from(
          data["results"].map((json) => EpisodeModel.fromJson(json)));
      _error = '';
      _locations = episodesList;
      notifyListeners();
    } catch (error) {
      _error = 'An error has occurred';
      notifyListeners();
    }
  }

  void nextPage() {
    if (_currentPage < _maxPages) {
      _currentPage++;
      fetchEpisodes();
    }
  }

  void prevPage() {
    if (_currentPage > 1) {
      _currentPage--;
      fetchEpisodes();
    }
  }
}
