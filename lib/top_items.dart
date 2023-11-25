import 'package:flutter/material.dart';

import 'homepage.dart';

// The page for displaying either the user's top artists or top tracks
class TopItems extends StatefulWidget {
  final Map<String, dynamic> userTopMonth;
  final Map<String, dynamic> userTopSix;
  final Map<String, dynamic> userTopAll;
  final String type;

  const TopItems({
    Key? key,
    required this.userTopMonth,
    required this.userTopSix,
    required this.userTopAll,
    required this.type,
  }) : super(key: key);

  @override
  _TopItemsState createState() => _TopItemsState();
}

class _TopItemsState extends State<TopItems> {
  Map<String, dynamic> userTop = {};

  @override
  void initState() {
    super.initState();
    userTop = widget.userTopSix; // Set the default time range to six months
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getAccentColor(),
        toolbarHeight: 50,
        title: Text('Top ${widget.type}', style: TextStyle(fontSize: 20)),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: getPrimaryColor(),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text('These are your top ${widget.type}'),
                Spacer(),
                DropdownButton<String>(
                  value: getUserTopTitle(userTop),
                  onChanged: (String? newValue) {
                    setState(() {
                      switch (newValue) {
                        case '1 month':
                          userTop = widget.userTopMonth;
                          break;
                        case '6 months':
                          userTop = widget.userTopSix;
                          break;
                        case 'All time':
                          userTop = widget.userTopAll;
                          break;
                      }
                    });
                  },
                  items: ['1 month', '6 months', 'All time']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: userTop['items'].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 30),
                        ClipRRect(
                          borderRadius: BorderRadius.circular((widget.type == 'artists') ? 15.0 : 0.0),
                          child: Image.network(
                            (widget.type == 'artists')
                                ? '${userTop['items'][index]['images'][0]['url']}'
                                : '${userTop['items'][index]['album']['images'][0]['url']}',
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
                                '${userTop['items'][index]['name']}',
                                style: const TextStyle(fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              if (widget.type == 'tracks')
                                Text(
                                  'by ${userTop['items'][index]['artists'][0]['name']}',
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

  String getUserTopTitle(Map<String, dynamic> userTop) {
    if (userTop == widget.userTopMonth) {
      return '1 month';
    } else if (userTop == widget.userTopSix) {
      return '6 months';
    } else {
      return 'All time';
    }
  }
}
