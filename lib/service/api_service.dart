import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/item.dart';

class ApiService {
  final String baseUrl =
      "http://127.0.0.1/rest/api"; // Ganti IP saat di perangkat

  Future<List<Item>> fetchItems() async {
    final response = await http.get(Uri.parse('$baseUrl/get.php'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Item>.from(data.map((item) => Item.fromJson(item)));
    } else {
      throw Exception("Failed to load items");
    }
  }

  Future<bool> createItem(Item item) async {
    final response = await http.post(
      Uri.parse('$baseUrl/post.php'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(item.toJson()),
    );
    return response.statusCode == 200;
  }

  Future<bool> updateItem(Item item) async {
    final response = await http.post(
      Uri.parse('$baseUrl/put.php'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(item.toJson()),
    );
    return response.statusCode == 200;
  }

  Future<bool> deleteItem(int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/delete.php'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'id': id}),
    );
    return response.statusCode == 200;
  }
}
