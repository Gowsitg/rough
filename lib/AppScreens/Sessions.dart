import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vanthar/Shared/Reusable.dart';
import 'package:vanthar/Shared/SearchBar.dart';
import 'SessionDetails.dart';
import '../ApiHelper/Session_Service.dart';

class Sessions extends StatefulWidget {
  const Sessions({super.key});

  @override
  State<Sessions> createState() => _SessionsState();
}

class _SessionsState extends State<Sessions> {
  int _currentPage = 1;
  int _itemsPerPage = 5;
  final List<int> _itemsPerPageOptions = [5, 10, 20, 30, 40, 50, 100];
  int _totalPages = 0;
  String filteredSession = '';
  List<dynamic> SessionData = [];
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    getSessionList();
  }

  getSessionList() async {
    isLoading = true;
    try {
      final response = await SessionService()
          .fetchSession(filteredSession, _currentPage, _itemsPerPage);

      if (response.statusCode == 200) {
        Map<String, dynamic> getData = jsonDecode(response.body);
        setState(() {
          SessionData = getData['data']['list'];
          final TotalPages = getData['data']['total_pages'];
          _totalPages = (TotalPages / _itemsPerPage).ceil();
          isLoading = false;
        });
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

  String getDate(String sessionDate) {
    if (sessionDate == null || sessionDate.isEmpty) {
      return 'Invalid date';
    }

    DateTime startDate = DateTime.parse(sessionDate);
    DateTime endDate = DateTime.now();

    Duration difference = endDate.difference(startDate);

    int dayCount = difference.inDays;
    if (dayCount == 0) {
      return "Today";
    } else if (dayCount == 1) {
      return "Yesterday";
    } else {
      return "Days: ${dayCount < 10 ? '0$dayCount' : dayCount}";
    }
  }

  void _Search(String query) {
    if (query.isNotEmpty) {
      setState(() {
        filteredSession = query;
      });
    } else {
      filteredSession = '';
    }
    getSessionList();
  }

  void _onItemsPerPageChanged(int? newValue) {
    if (newValue != null) {
      setState(() {
        _itemsPerPage = newValue;
        _currentPage = 1;
        getSessionList();
      });
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
        getSessionList();
      });
    }
  }

  void _goToNextPage() {
    if (_currentPage < _totalPages) {
      setState(() {
        _currentPage++;
        getSessionList();
      });
    }
  }

  navigateSessions(sessionId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SessionDetaile(sessionId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(217, 217, 217, 1),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Searchbar(onSearch: _Search),
            SizedBox(
              height: 20,
            ),
            // Text(
            //   'Recorded Session',
            //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            Container(
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Color.fromRGBO(243, 148, 81, 1),
                      ))
                    : Column(children: [
                        for (var sessionValue in SessionData)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              sessionValue['session_type'] == 'recording'
                                  ? Text(
                                      'Recorded Session',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ) :
                                    Text('Live Session',style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),),
                                    SizedBox(
                                height: 15,
                              ),
                              sessionValue['session_type'] == 'recording'
                                  ? Text(
                                getDate(
                                    sessionValue['session_date'].toString()),
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey[800]),
                              ): Text(''),
                              SizedBox(
                                height: 15,
                              ),
                              GestureDetector(
                                onTap: () => navigateSessions(
                                    sessionValue['session_no']),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(.4),
                                          BlendMode.multiply),
                                      image: AssetImage(
                                          'assets/images/course1.jpeg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.play_circle_outlined,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  sessionValue['session_title'] ?? '--',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                      ])),
            SizedBox(
              height: 20,
            ),
            if (SessionData.length >= 5)
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
                    onPressed:
                        _currentPage < _totalPages ? _goToNextPage : null,
                  ),
                ],
              )
          ],
        ),
      )),
    );
  }
}
