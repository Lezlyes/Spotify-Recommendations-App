//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spotify_rec_sp29_green/fetch.dart';
import 'package:spotify_rec_sp29_green/main.dart';
import 'package:spotify_rec_sp29_green/recommendations.dart';
import 'package:spotify_rec_sp29_green/top_items.dart';
import 'package:spotify_rec_sp29_green/settings.dart';

// The Home Page of the app
class HomePage extends StatefulWidget {
  final Map<String, dynamic> userTop;
  final Map<String, dynamic> userData;

  const HomePage({Key? key, required this.userData, required this.userTop}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
 Color getPrimaryColor() => _HomePageState.primary;
 Color getAccentColor() => _HomePageState.accent;

class _HomePageState extends State<HomePage> {
  static Map<String, dynamic> artistTopSix = {};
  static Map<String, dynamic> artistTopAll = {};
  static Map<String, dynamic> trackTopOne = {};
  static Map<String, dynamic> trackTopSix = {};
  static Map<String, dynamic> trackTopAll = {};
  static Color primary = Colors.black38;
  static Color accent = Colors.green;

  void _updateTheme(Color newPrimary, Color newAccent) {
    setState(() {
      accent = newAccent;
      primary = newPrimary;
    });
  }


  @override
  Widget build(BuildContext context) {
    // JsonEncoder encoder = const JsonEncoder.withIndent('  '); // Create a JSON encoder with indentation
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        automaticallyImplyLeading: false,
        backgroundColor: accent,
        title: const Text('Spotitops', style: TextStyle(fontSize:18)),

        // Log out button
        leading: IconButton(
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Are you sure you want to log out?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Continue with the logout logic
                        final route = MaterialPageRoute(builder: (context) => MyHomePage());
                        Navigator.of(context).pushAndRemoveUntil(route, (Route<dynamic> route) => false);
                      },
                      child: Text('Yes'),
                    ),
                  ],
                );
              }
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage(onThemeChanged: _updateTheme)),
                    );
            },
          )
        ]


      ),
      body: Container(
        decoration: BoxDecoration(
          color: primary,
        ),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome back, ${widget.userData['display_name']}',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 30),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.network('${widget.userData['images'][0]['url']}', width: 50, height: 50),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.userData['display_name']}', // Display pretty-printed JSON data
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text('Followers: ${widget.userData['followers']['total']}'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                 const Text(
                  'Your Recent Favorites',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 30),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image.network('${widget.userTop['items'][0]['images'][0]['url']}', width: 30, height: 30),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.userTop['items'][0]['name']}', // Display pretty-printed JSON data
                          style: const TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 30),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image.network('${widget.userTop['items'][1]['images'][0]['url']}', width: 30, height: 30),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.userTop['items'][1]['name']}', // Display pretty-printed JSON data
                          style: const TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 30),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image.network('${widget.userTop['items'][2]['images'][0]['url']}', width: 30, height: 30),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.userTop['items'][2]['name']}', // Display pretty-printed JSON data
                          style: const TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 30),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10), backgroundColor: accent,
                    ),
                    child: const Text('Get Your Top Artists', style: TextStyle(fontSize:14)),
                    onPressed: () async {
                      if(artistTopSix.isEmpty) {
                        artistTopSix = await Fetch.getTopItems('artists', 'medium_term');
                      }
                      if(artistTopAll.isEmpty) {
                        artistTopAll = await Fetch.getTopItems('artists', 'long_term');
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TopItems(userTopMonth: widget.userTop, userTopSix: artistTopSix, userTopAll: artistTopAll, type: 'artists')),
                      );
                    }
                ),

                const SizedBox(height: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10), backgroundColor: accent,
                    ),
                    child: const Text('Get Your Top Tracks', style: TextStyle(fontSize:14)),
                    onPressed: () async {
                      if(trackTopOne.isEmpty) {
                        trackTopOne = await Fetch.getTopItems('tracks', 'short_term');
                      }
                      if(trackTopSix.isEmpty) {
                        trackTopSix = await Fetch.getTopItems('tracks', 'medium_term');
                      }
                      if(trackTopAll.isEmpty) {
                        trackTopAll = await Fetch.getTopItems('tracks', 'long_term');
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TopItems(userTopMonth: trackTopOne, userTopSix: trackTopSix, userTopAll: trackTopAll, type: 'tracks')),
                      );
                    }
                ),

                const SizedBox(height: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10), backgroundColor: accent,
                    ),
                    child: const Text('Get Recommendations', style: TextStyle(fontSize:14)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecommendationsPage(userTop: widget.userTop)),
                      );
                    }
                ),
              ],
            )
        ),
      ),
    );
  }
}