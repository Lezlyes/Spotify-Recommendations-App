import 'package:flutter/material.dart';
import 'log_in.dart';
import 'dart:developer' as devLog;

// The main class, starts the app
// Shows a page with a Log In button
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // The root of the application.
  @override
  Widget build(BuildContext context) {
    devLog.log('Log is working');
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text('Spotitops', style: TextStyle(fontSize:20)),
        backgroundColor: Colors.green,
        toolbarHeight: 50,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Log in with your Spotify account to view your top artists, tracks, and recommendations',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                      )
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
           ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(15), backgroundColor: Colors.green,
            ),
            child: const Text('Log in', style: TextStyle(fontSize:20)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LogIn()),
              );
            }
        ),
          ]
        )
    )
    );
  }

}
