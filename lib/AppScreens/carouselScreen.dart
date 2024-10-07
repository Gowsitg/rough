import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../ApiHelper/Session_Service.dart';
import '../Shared/VideoPlayer.dart';
import '../Shared/Reusable.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';
// import 'package:path_provider/path_provider.dart';

class CarouselSlides extends StatefulWidget {
  const CarouselSlides({super.key});

  @override
  State<CarouselSlides> createState() => _CarouselSlidesState();
}

class _CarouselSlidesState extends State<CarouselSlides> {
  int _currentPage = 1;
  int _itemsPerPage = 3;
  String filteredSession = '';
  List<dynamic> SessionData = [];
  late bool isLoading;
  int _currentIndex = 0;
  String? _thumbnailPath;

  @override
  void initState() {
    super.initState();
    getSessionList();
    // _generateThumbnail();
  }

//   Future<void> _generateThumbnail() async {
//   try {
//     final thumbnailPath = (await getTemporaryDirectory()).path;
//     final fileName = await VideoThumbnail.thumbnailFile(
//       video: "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
//       thumbnailPath: thumbnailPath,
//       imageFormat: ImageFormat.PNG,
//       maxHeight: 64,
//       quality: 75,
//     );
//     if (fileName != null) {
//       print('Thumbnail generated: $fileName');
//     } else {
//       print('Thumbnail generation failed.');
//     }
//   } catch (e) {
//     print('Error generating thumbnail: $e');
//   }
// }

  getSessionList() async {
    isLoading = true;
    try {
      final response = await SessionService()
          .fetchSession(filteredSession, _currentPage, _itemsPerPage);

      if (response.statusCode == 200) {
        Map<String, dynamic> getData = jsonDecode(response.body);
        setState(() {
          SessionData = getData['data']['list'];
          isLoading = false;
        });
        // print(SessionData[0]['session_type']);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    }
  }

  navigateVideo(recUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => UniversalVideoPlayer(videoUrl: recUrl)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : CarouselSlider.builder(
                      itemCount: SessionData.length,
                      itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) {
                        final session = SessionData[itemIndex];
                        return Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      session['recording_link'] ?? ''),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Text overlay
                            GestureDetector(
                              onTap: () =>
                                  navigateVideo(session['recording_link']),
                                
                              child: Container(
                                padding: const EdgeInsets.all(20.0),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      session['session_title'] ?? 'No Title',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                    capitalizeEachWord(  session['session_type'] ??
                                          '--',),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      options: CarouselOptions(
                        height: 230,
                        autoPlay: SessionData.length > 1 &&
                                SessionData[0]['session_type'] == 'recording'
                            ? true
                            : false,
                        viewportFraction: 1,
                        enableInfiniteScroll: SessionData.length > 1 &&
                                SessionData[0]['session_type'] == 'recording'
                            ? true
                            : false,
                        autoPlayInterval: const Duration(seconds: 13),
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                    ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(SessionData.length, (index) {
                  return Container(
                    width: 50,
                    height: 5.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: _currentIndex == index
                          ? const Color.fromRGBO(0, 0, 0, 1)
                          : const Color.fromRGBO(8, 8, 38, .3),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
