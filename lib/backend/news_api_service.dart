import 'package:empower_women/backend/thread.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsApiService {
  static const String _apiKey = '77641c3a40714e5085f32d6e1e9bcee0';
  static const String _baseUrl = 'https://newsapi.org/v2/everything';

  static Future<List<News>> fetchNews({String query = 'women'}) async {
    final uri = Uri.parse(_baseUrl).replace(queryParameters: {
      'q': query,
      'apiKey': _apiKey,
    });

    final response = await http.get(uri);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final articles = data['articles'] as List;
      return articles.map((article) => News.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load news.');
    }
  }
}
