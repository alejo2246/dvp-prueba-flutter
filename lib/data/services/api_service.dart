import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://rickandmortyapi.com/api";

  Future<http.Response> getData(String type, String queryParams) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$type/$queryParams'),
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }
}
