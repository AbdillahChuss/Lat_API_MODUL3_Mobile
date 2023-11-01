import 'dart:convert';
import 'package:http/http.dart' as http;

import '../MODEL_API/model_api.dart';

class ApiService {
  static Future<Welcome> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=tesla&from=2023-09-28&sortBy=publishedAt&apiKey=73568fc7fc0447ec8dc61ba37ffdd37c'));
    if (response.statusCode == 200) {
      return Welcome.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal mengambil data');
    }
  }
}
