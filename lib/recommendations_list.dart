import 'package:flutter/material.dart';
import 'package:spotify_rec_sp29_green/homepage.dart';

// The page that displays all of the recommendations that have been generated
class RecommendationsList extends StatelessWidget {
  final Map<String, dynamic> recommendations;
  final String type;

  RecommendationsList({required this.recommendations, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: getAccentColor(),
          toolbarHeight: 50,
          title: const Text('Recommendations', style: TextStyle(fontSize: 20)),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: getPrimaryColor(),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: recommendations['tracks'].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 30),
                          ClipRRect(
                            child: Image.network(
                              '${recommendations['tracks'][index]['album']['images'][0]['url']}',
                              width: 30,
                              height: 30,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${recommendations['tracks'][index]['name']}',
                                  style: const TextStyle(fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                Text(
                                  'by ${recommendations['tracks'][index]['artists'][0]['name']}',
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],

          ),
        )
    );
  }
}
