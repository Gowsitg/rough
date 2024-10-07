import 'package:flutter/material.dart';
import 'package:vanthar/Shared/SearchBar.dart';
import 'dart:convert';
import '../ApiHelper/ApiServices.dart';
import '../Shared/Reusable.dart';
import 'CourseDetails.dart';

class AllCourses extends StatefulWidget {
  const AllCourses({super.key});

  @override
  State<AllCourses> createState() => _AllCoursesState();
}

class _AllCoursesState extends State<AllCourses> {
  List<dynamic> courses = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getList();
  }

  getList() async {
    // setState(() {
    //   isLoading = false;
    // });
    try {
      final res = await getCourse();
      if (res.statusCode == 200) {
        setState(() {
          Map<String, dynamic> jsonResponse = jsonDecode(res.body);
          courses = jsonResponse['data']['list'];
          isLoading = false;
        });
      }
    } catch (error) {
      isLoading = false;
      print('Error: ${error}');
    }
  }

  onSearch(value) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(217, 217, 217, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(217, 217, 217, 1),
        title: null,
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 35),
            Center(
              child: Text(
                'Courses',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(243, 148, 81, 1),
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Searchbar(onSearch: onSearch),
                  SizedBox(
                    height: 20,
                  ),
                  for (var course in courses)
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.white.withOpacity(.7),
                      margin: EdgeInsets.only(bottom: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(15),
                            height: 170,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  child: Image.network(
                                    course['thumbnail'] ??
                                        'https://static.vecteezy.com/system/resources/thumbnails/004/141/669/small/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                    right: 0,
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Container(
                                          width: 40,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 14,
                                                color: Colors.amber,
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text(
                                                course['review'] ?? '0',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              )
                                            ],
                                          )),
                                    )),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                          child: Image.network(
                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAd5avdba8EiOZH8lmV3XshrXx7dKRZvhx-A&s',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        course['created_by_name'] ?? '--',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      course['category_name'] ?? '--',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(243, 148, 81, 1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Coursedetails(course['id'])),
                                          );
                                        },
                                        child: Text(
                                          'Enroll',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color:
                                                  Colors.white), // Text color
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(course['title'] ?? '--',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 10),
                                Text(
                                  removeHtmlTags(
                                      course['long_description'] ?? '--'),
                                  style: TextStyle(fontSize: 14),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_today,
                                            size: 14, color: Colors.grey[600]),
                                        SizedBox(width: 8),
                                        Text(
                                          formatDate(
                                              course['created_at'] ?? '---'),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 30),
                                    Row(
                                      children: [
                                        Icon(Icons.punch_clock_sharp,
                                            size: 14, color: Colors.grey[600]),
                                        SizedBox(width: 8),
                                        Text(
                                          course['duration'] ?? '--',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                //  SizedBox(width: 10),
                                //     Row(
                                //       children: [
                                //         Icon(Icons.message,
                                //             size: 14, color: Colors.grey[600]),
                                //         SizedBox(width: 8),
                                //         Text(
                                //           'Comments',
                                //           style: TextStyle(
                                //               fontSize: 12, color: Colors.grey[600]),
                                //         ),
                                //       ],
                                //     ),

                                SizedBox(height: 20),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                ],
              )),
    );
  }
}
