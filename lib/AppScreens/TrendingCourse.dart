import 'dart:convert';
import 'package:flutter/material.dart';
import '../ApiHelper/ApiServices.dart';
import './AllCourse.dart';
import './CourseDetails.dart';

class TrendingCourse extends StatefulWidget {
  final Function onNavigateToCourses;

  const TrendingCourse({Key? key, required this.onNavigateToCourses})
      : super(key: key);

  @override
  State<TrendingCourse> createState() => _TrendingCourseState();
}

class _TrendingCourseState extends State<TrendingCourse> {
  List<dynamic> courses = [];

  @override
  void initState() {
    super.initState();
    getList();
  }

  getList() async {
    try {
      final res = await getCourse();
      if (res.statusCode == 200) {
        setState(() {
          Map<String, dynamic> jsonResponse = jsonDecode(res.body);
          courses = jsonResponse['data']['list'];
        });
        // print('Res: ${courses[1]}');
      }
    } catch (error) {
      print('Error: ${error}');
    }
  }

  viewall() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AllCourses()),
    );
    // AllCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending Courses',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: viewall,
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
          SizedBox(
            height: 13,
          ),
          Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: [
              for (var course in courses)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Coursedetails(course['id'])),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.43,
                    child: Column(
                      children: [
                        Card(
                            child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 120,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(.3),
                                      BlendMode.multiply),
                                  image:
                                      NetworkImage(course['thumbnail'] ?? ''),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, bottom: 10),
                                    child: Row(
                                      children: List<Widget>.generate(
                                        5,
                                        (index) {
                                          double rating = double.tryParse(
                                                  course['review'] ?? '0') ??
                                              0.0;

                                          if (index < rating.floor()) {
                                            return Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 15,
                                            );
                                          } else if (index == rating.floor() &&
                                              rating % 1 >= 0.5) {
                                            return Icon(
                                              Icons.star_half,
                                              color: Colors.amber,
                                              size: 15,
                                            );
                                          } else {
                                            return Icon(
                                              Icons.star_border,
                                              color: Colors.amber,
                                              size: 15,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  )),
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    children: [
                                      Text(
                                        course['category_name'] ?? 'No Title',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            'Lessons 1-5',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey[900]),
                                          ),
                                          Text(
                                            course['duration'],
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey[900]),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                            ),
                            SizedBox(height: 15),
                          ],
                        )),
                      ],
                    ),
                  ),
                )
            ],
          ),
          SizedBox(
            height: 13,
          ),
        ]));
  }
}
