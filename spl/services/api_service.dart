import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/disaster_model.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<Disaster>> fetchDisasters() async {
    final response = await http.get(Uri.parse('$baseUrl/disaster/rest/api.php'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print('Response JSON: $jsonResponse'); // Debug print

      if (jsonResponse is Map && jsonResponse.containsKey('records')) {
        List<dynamic> recordsList = jsonResponse['records'];
        return recordsList.map((disaster) => Disaster.fromJson(disaster)).toList();
      } else {
        throw Exception('Unexpected JSON format');
      }
    } else {
      throw Exception('Failed to load disasters');
    }
  }

  Future<List<String>> fetchDisasterNames() async {
    final disasters = await fetchDisasters();
    return disasters.map((disaster) => disaster.name).toList();
  }

  Future<void> addDisaster(Disaster disaster) async {
    final response = await http.post(
      Uri.parse('$baseUrl/disaster/rest/api.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(disaster.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add disaster');
    }
  }

  Future<void> updateDisaster(Disaster disaster) async {
    final response = await http.put(
      Uri.parse('$baseUrl/disaster/rest/api.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(disaster.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update disaster');
    }
  }

  Future<void> deleteDisaster(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/disaster/rest/api.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete disaster');
    }
  }
}
