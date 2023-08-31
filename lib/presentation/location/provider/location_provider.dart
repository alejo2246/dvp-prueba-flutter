import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rick_morty_dvp_prueba/data/services/api_service.dart';
import 'package:rick_morty_dvp_prueba/domain/models/location_model.dart';

class LocationProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  String _error = '';
  int _maxPages = 1;
  int _currentPage = 1;
  List<LocationModel> _locations = [];
  String _typeQuery = '';
  String _searchQuery = "";
  String _dimensionQuery = '';

  String get searchQuery => _searchQuery;
  String get typeQuery => _typeQuery;
  String get dimensionQuery => _dimensionQuery;
  String get error => _error;
  List<LocationModel> get locations => _locations;
  int get maxPages => _maxPages;
  int get currentPage => _currentPage;

  void setTypeQuery(String type) {
    _typeQuery = type;
  }

  void setDimensionQuery(String dimension) {
    _dimensionQuery = dimension;
  }

  void applyFiltersAndFetch() {
    _currentPage = 1;
    fetchLocations();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _currentPage = 1;
    fetchLocations();
  }

  Future<void> fetchLocations() async {
    try {
      String queryParams = "?page=$_currentPage";
      if (_searchQuery.isNotEmpty) {
        queryParams += "&name=$_searchQuery";
      }

      if (_typeQuery.isNotEmpty) {
        queryParams += "&type=$_typeQuery";
      }

      if (_dimensionQuery.isNotEmpty) {
        queryParams += "&dimension=$_dimensionQuery";
      }
      final response = await _apiService.getData("location", queryParams);

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
      List<LocationModel> locationsList = List<LocationModel>.from(
          data["results"].map((json) => LocationModel.fromJson(json)));
      _error = '';
      _locations = locationsList;
      notifyListeners();
    } catch (error) {
      _error = 'An error has occurred';
      notifyListeners();
    }
  }

  void nextPage() {
    if (_currentPage < _maxPages) {
      _currentPage++;
      fetchLocations();
    }
  }

  void prevPage() {
    if (_currentPage > 1) {
      _currentPage--;
      fetchLocations();
    }
  }
}
