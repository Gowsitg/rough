import 'package:flutter/material.dart';
import 'Sessions.dart';

class WatchHistory extends StatefulWidget {
   final Function onNavigateTosession; 

  const WatchHistory({Key? key, required this.onNavigateTosession}) : super(key: key);

  @override
  State<WatchHistory> createState() => _WatchHistoryState();
}

class _WatchHistoryState extends State<WatchHistory> {
  final List<Map<String, String>> _videos = [
    {
      'thumbnail': 'assets/images/course1.jpeg',
      'title': 'Video Title 1',
    },
    {
      'thumbnail': 'assets/images/course1.jpeg',
      'title': 'Video Title 2',
    },
    {
      'thumbnail': 'assets/images/course1.jpeg',
      'title': 'Video Title 2',
    },
  ];

  void viewAll() {
   navigateCourse () ;
  }

  navigateCourse () {
   widget.onNavigateTosession();
 }

  void playVideo(String title) {
      widget.onNavigateTosession();
  }
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Continue Watching',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: viewAll,
                child: Text(
                  'View all',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var video in _videos.take(2))
                Container(
                  width: MediaQuery.of(context).size.width * 0.43,
                  child: Column(
                    children: [
                      Card(
                        child: GestureDetector(
                            onTap: () => navigateCourse(),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(video['thumbnail']!),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.play_circle_outlined,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      video['title'] ?? 'No Title',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            )),
                      )
                    ],
                  ),
                )
            ],
          )
        ],
      ),
    );
  }
}
