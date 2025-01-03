import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  //ye hamari post api ki link
  final String baseUrl = "https://dine-near-backend.vercel.app/api/v1/map/inMap";

  Future<List<Map<String, dynamic>>?> fetchNearbyRestaurants({
    required double current_latitude,
    required double current_longitude,
    required double target_latitude,
    required double target_longitude,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "latitude": current_latitude,
          "longitude": current_longitude,
          "target lat" : target_latitude,
          "target long" : target_longitude,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['restaurants']);
      } else {
        print("Failed to fetch restaurants: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error fetching restaurants: $e");
      return null;
    }
  }
}
