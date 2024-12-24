import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://apidojo-hm-hennes-mauritz-v1.p.rapidapi.com';
  static const String apiKey = '7a3402cc20msh94256ca59f133e0p156c80jsn5fa71aa0e09a';

  Future<List<Product>> getProducts(int page, String category) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/list?categories=$category&currentpage=$page&pagesize=30'),
      headers: {
        'X-RapidAPI-Key': apiKey,
        'X-RapidAPI-Host': 'apidojo-hm-hennes-mauritz-v1.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;
      return results.map((item) => Product.fromJson(item)).toList();
    }
    throw Exception('Failed to load products');
  }
}
