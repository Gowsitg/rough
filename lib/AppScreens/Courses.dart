import 'package:flutter/material.dart';
import 'package:vanthar/AppScreens/AllCourse.dart';
import 'package:vanthar/Shared/SearchBar.dart';
import 'dart:convert';
import '../ApiHelper/Course_Service.dart';
import '../Shared/Reusable.dart';
import 'CourseDetails.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  List<dynamic> courses = [];
  int _currentPage = 1;
  int _itemsPerPage = 5;
  final List<int> _itemsPerPageOptions = [5, 10, 20, 30, 40, 50, 100];
  int _totalPages = 0;
  String filteredTrainers = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getList();
  }

  getList() async {
    try {
      final res = await SessionService()
          .SubscribedCourses(filteredTrainers, _currentPage, _itemsPerPage);

      if (res.statusCode == 200) {
        setState(() {
          Map<String, dynamic> jsonResponse = jsonDecode(res.body);
          courses = jsonResponse['data']['list'];
          final TotalPages = jsonResponse['data']['total_pages'];
          _totalPages = (TotalPages / _itemsPerPage).ceil();
          isLoading = false;
        });
        print('Res: ${courses}');
      } else {
        throw Exception('Failed to load trainers: ${res.reasonPhrase}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        throw Exception('Failed to load trainers: $e');
        isLoading = false;
      });
    }
  }

  void _filterTrainers(String query) {
    if (query.isNotEmpty) {
      setState(() {
        filteredTrainers = query;
      });
    } else {
      filteredTrainers = '';
    }
    getList();
  }

  void _onItemsPerPageChanged(int? newValue) {
    if (newValue != null) {
      setState(() {
        _itemsPerPage = newValue;
        _currentPage = 1;
        getList();
      });
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
        getList();
      });
    }
  }

  void _goToNextPage() {
    if (_currentPage < _totalPages) {
      setState(() {
        _currentPage++;
        getList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(217, 217, 217, 1),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(
              height: 14,
            ),
            Searchbar(onSearch: _filterTrainers),
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
                            borderRadius: BorderRadius.all(Radius.circular(15)),
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
                                    width: 45,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
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
                          // Positioned(
                          //     bottom: 10,
                          //     left: 10,
                          //     child: Chip(
                          //       label: Text(
                          //           capitalizeEachWord(
                          //             course['course_status'],
                          //           ),
                          //           style: TextStyle(
                          //               color: Colors.white, fontSize: 14)),
                          //       labelPadding: EdgeInsets.symmetric(vertical: 0),
                          //       padding: EdgeInsets.symmetric(
                          //           horizontal: 5, vertical: 0),
                          //       backgroundColor:
                          //           course['course_status'] == 'inprogress'
                          //               ? Colors.red
                          //               : Colors.green,
                          //       shape: RoundedRectangleBorder(
                          //         side: BorderSide(
                          //             color: Colors.transparent, width: 1),
                          //         borderRadius: BorderRadius.circular(
                          //             8), // Rounded corners
                          //       ),
                          //     )),
                          // Positioned(
                          //   bottom: 10,
                          //   left: 10,
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Container(
                          //         height: 40,
                          //         width: 40,
                          //         child: ClipRRect(
                          //           borderRadius:
                          //               BorderRadius.all(Radius.circular(50)),
                          //           child: Image.network(
                          //             'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAd5avdba8EiOZH8lmV3XshrXx7dKRZvhx-A&s',
                          //             fit: BoxFit.cover,
                          //           ),
                          //         ),
                          //       ),
                          //       SizedBox(width: 10),
                          //       Text(
                          //         course['created_by_name'] ?? '--',
                          //         style: TextStyle(
                          //             fontSize: 16,
                          //             color: Colors.white,
                          //             fontWeight: FontWeight.bold),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                course['category_name'] ?? '--',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
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
                                              Coursedetails(course['course_details'])),
                                    );
                                  },
                                  child: Text(
                                    'Explore',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white), // Text color
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(course['title'] ?? '--',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Chip(
                                label: Text(
                                    capitalizeEachWord(
                                      course['course_status'],
                                    ),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14)),
                                labelPadding: EdgeInsets.symmetric(vertical: 0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 0),
                                backgroundColor:
                                    course['course_status'] == 'inprogress'
                                        ? Colors.red
                                        : Colors.green,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.transparent, width: 1),
                                  borderRadius: BorderRadius.circular(
                                      8), // Rounded corners
                                ),
                              ),
                          // Text(
                          //   removeHtmlTags(
                          //       course['long_description'] ?? '--'),
                          //   style: TextStyle(fontSize: 14),
                          //   maxLines: 3,
                          //   overflow: TextOverflow.ellipsis,
                          // ),
                          // SizedBox(height: 20),
                          // Row(
                          //   children: [
                          //     Row(
                          //       children: [
                          //        Text(
                          //           'Status: ',
                          //           style: TextStyle(
                          //               fontSize: 16,
                          //               color: Colors.grey[600]),
                          //         ),
                          //         SizedBox(width: 8),
                          //         Text(
                          //           course['course_status'],
                          //           style: TextStyle(
                          //               fontSize: 16,
                          //               color: Colors.grey[600]),
                          //         ),
                          //       ],
                          //     ),
                          // SizedBox(width: 30),
                          // Row(
                          //   children: [
                          //     Icon(Icons.punch_clock_sharp,
                          //         size: 14, color: Colors.grey[600]),
                          //     SizedBox(width: 8),
                          //     Text(
                          //       course['duration'] ?? '--',
                          //       style: TextStyle(
                          //           fontSize: 12,
                          //           color: Colors.grey[600]),
                          //     ),
                          //   ],
                          // ),
                          // ],
                          // ),
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
              ),
              if(courses.length >= 5)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.chevron_left_outlined,
                    size: 35,
                  ),
                  onPressed: _currentPage > 1 ? _goToPreviousPage : null,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: DropdownButton<int>(
                    value: _itemsPerPage,
                    items: _itemsPerPageOptions.map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: _onItemsPerPageChanged,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.chevron_right_outlined,
                    size: 35,
                  ),
                  onPressed: _currentPage < _totalPages ? _goToNextPage : null,
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AllCourses(),
            ),
          );
        },
        label: Text("New"),
        icon: Icon(Icons.add),
        isExtended: true,
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(243, 148, 81, 1),
      ),
    );
  }
}
