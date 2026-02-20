import 'dart:convert';
import 'package:http/http.dart' as http;

class SpoonacularService {
  final String apiKey = 'YOUR_API_KEY'; // replace with your key
  final String baseUrl = 'https://api.spoonacular.com';

  // Search food by name
  Future<List<dynamic>> searchFood(String query) async {
    final url = Uri.parse('$baseUrl/recipes/complexSearch?query=$query&number=10&apiKey=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results']; // list of recipes
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  // Get image URL from recipe
  String getImage(String imageName) {
    return 'https://spoonacular.com/recipeImages/$imageName';
  }
}