import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as devLog;
import 'log_in.dart';

// A helper class for making various API calls
class Fetch {

  static Future<Map<String, dynamic>> getTopItems(String item, String term) async {
    final accessToken = await secureStorage.read(key: 'access_token');
    final Uri tracksUri = Uri.parse('https://api.spotify.com/v1/me/top/$item?time_range=$term&limit=50');
    final response = await http.get(
      tracksUri,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      devLog.log('Validated code 200');
      final topTracks = json.decode(response.body);
      return topTracks;
    } else {
      devLog.log('Error: failed to fetch user top tracks');
      devLog.log('Error: HTTP status ${response.statusCode}');
      devLog.log('Error: HTTP reason ${response.reasonPhrase}: ${response.body}');
      throw Exception('Failed to fetch user profile');
    }
  }

  static Future<Map<String, dynamic>> getRecommendations({
    List<String> artistSeeds = const [],
    List<String> genreSeeds = const [],
    double happiness = 0.5,
    double instrumentalness = 0.5,
    double popularity = 0.5,
  }) async {
    final accessToken = await secureStorage.read(key: 'access_token');

    String? seedArtists = artistSeeds.isNotEmpty ? artistSeeds.join(',') : null;
    final Uri recommendationsUri = Uri.parse('https://api.spotify.com/v1/recommendations?'
        'seed_artists=$seedArtists&'
        'target_valence=$happiness&'
        'target_instrumentalness=$instrumentalness&'
        'target_popularity=${(popularity * 100).round()}');

    devLog.log('https://api.spotify.com/v1/recommendations?'
        'seed_artists=$seedArtists&'
        'target_valence=$happiness&'
        'target_instrumentalness=$instrumentalness&'
        'target_popularity=${(popularity * 100).round()}');

    final response = await http.get(
      recommendationsUri,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      devLog.log('Validated code 200');
      final recommendations = json.decode(response.body);
      return recommendations;
    } else {
      devLog.log('Error: failed to fetch recommendations');
      devLog.log('Error: HTTP status ${response.statusCode}');
      devLog.log('Error: HTTP reason ${response.reasonPhrase}: ${response.body}');
      throw Exception('Failed to fetch recommendations');
    }
  }
}