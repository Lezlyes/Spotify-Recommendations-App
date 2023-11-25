import 'package:flutter/material.dart';
class SettingsPage extends StatefulWidget {
  final Function(Color, Color) onThemeChanged;

  SettingsPage({required this.onThemeChanged});
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

// The page that displays settings (used now for changing themes)
class _SettingsPageState extends State<SettingsPage> {
  String _selectedTheme = 'default';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Theme:'),
            DropdownButton<String>(
              value: _selectedTheme,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTheme = newValue!;
                });
              },
              items: <String>['default', 'cherry blossom', 'ice', 'forest', 'red velvet']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                switch(_selectedTheme){
                  case 'default':
                  widget.onThemeChanged(Colors.black38, Colors.green);
                  break;
                  case 'cherry blossom':
                  widget.onThemeChanged(Colors.brown, Colors.pinkAccent);
                  break;
                  case 'ice':
                  widget.onThemeChanged(Colors.lightBlueAccent, Colors.blue);
                  break;
                  case 'forest':
                  widget.onThemeChanged(const Color.fromRGBO(12, 49, 1, 100), const Color.fromRGBO(62, 105, 49, 100));
                  break;
                  case 'red velvet':
                    widget.onThemeChanged(const Color.fromRGBO(89, 8, 8, 100), const Color.fromRGBO(209, 28, 28, 100));
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}