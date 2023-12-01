import 'package:flutter/material.dart';
import 'package:spotify_rec_sp29_green/fetch.dart';
import 'package:spotify_rec_sp29_green/recommendations_list.dart';
import 'homepage.dart';

// The page that allows the user to choose values for recommendations
class RecommendationsPage extends StatefulWidget {
  final Map<String, dynamic> userTop;

  RecommendationsPage({required this.userTop});

  @override
  _RecommendationsPageState createState() => _RecommendationsPageState();
}

class _RecommendationsPageState extends State<RecommendationsPage> {
  double instrumentalness = 0.5;
  double happiness = 0.5;
  double popularity = 0.5;

  @override
  Widget build(BuildContext context) {
    List<String> artistIds = [];

    // Extract the top 5 artist IDs from userTop
    if (widget.userTop.containsKey('items')) {
      for (var i = 0; i < 5 && i < widget.userTop['items'].length; i++) {
        var artist = widget.userTop['items'][i]['id'];
        if (artist != null) {
          artistIds.add(artist);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommendations'),
        backgroundColor: getAccentColor(),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: getPrimaryColor(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Instrumentalness: ${instrumentalness.toStringAsFixed(2)}'),
              Slider(
                activeColor: getAccentColor(),
                thumbColor: getAccentColor(),
                value: instrumentalness,
                onChanged: (value) {
                  setState(() {
                    instrumentalness = value;
                  });
                },
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: '$instrumentalness',
              ),
              const SizedBox(height: 20),
              Text('Happiness: ${happiness.toStringAsFixed(2)}'),
              Slider(
                activeColor: getAccentColor(),
                thumbColor: getAccentColor(),
                value: happiness,
                onChanged: (value) {
                  setState(() {
                    happiness = value;
                  });
                },
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: '$happiness',
              ),
              const SizedBox(height: 20),
              Text('Popularity: ${popularity.toStringAsFixed(2)}'),
              Slider(
                activeColor: getAccentColor(),
                thumbColor: getAccentColor(),
                value: popularity,
                onChanged: (value) {
                  setState(() {
                    popularity = value;
                  });
                },
                min: 0.00,
                max: 1.00,
                divisions: 100,
                label: '$popularity',
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10), backgroundColor: getAccentColor(),
                ),
                onPressed: () async {
                  final recommendations = await Fetch.getRecommendations(
                    instrumentalness: instrumentalness,
                    happiness: happiness,
                    popularity: popularity,
                    artistSeeds: artistIds,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecommendationsList(recommendations: recommendations, type: 'tracks'),
                    ),
                  );
                },
                child: const Text('Get Recommendations'),
              ),
            ],
          ),
        ),
      )
    );
  }
}
