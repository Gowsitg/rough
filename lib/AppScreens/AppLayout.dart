import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'sideNav.dart';
import 'Home.dart';
import 'Assessments.dart';
import 'Courses.dart';
import 'Sessions.dart';
import '../ApiHelper/ApiServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(home: AppLayout()));
}

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _navigateToCourses() {
    setState(() {
      _selectedIndex = 2; 
    });
  }

  void _navigateToSession() {
    setState(() {
      _selectedIndex = 3; 
    });
  } 
  
  void _navigateToAssesment() {
    setState(() {
      _selectedIndex = 1; 
    });
  }

  final List<Widget> _widgetOptions = [];

  @override
  void initState() {
    super.initState();
    
    getUser();

    _widgetOptions.add(
      Home(
        scaffoldKey: _scaffoldKey,
        onNavigateToCourses: _navigateToCourses, 
        onNavigateTosession: _navigateToSession,
        onNavigateToAssessment: _navigateToAssesment, 
      ),
    );
    _widgetOptions.add(Assessment());
    _widgetOptions.add(Courses());
    _widgetOptions.add(Sessions());
  }

 getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

  getUser() async {
    //  String? token = getToken();


    //    final tokenjcode = jsonDecode(token);
    //        print(data['data']);
    //        print(tokenjcode);
    //       snackBarMsg('Login Successfuuly!');
    //   try {
    //     final response = await getUserDetaile();
    //      print('responce: ${response.body}');       
    //      print('responce: ${response.statusCode}');       

    //   } catch (e) {

    //   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _selectedIndex == 0
          ? null
          : AppBar(
              elevation: 0,
              backgroundColor: Color.fromRGBO(217, 217, 217, 1),
              leading: IconButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  )),
                ),
                icon: Icon(Icons.menu, size: 30, color: Colors.black),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.notifications, color: Colors.black),
                  onPressed: () {
                    // Handle notifications
                  },
                ),
              ],
            ),
      drawer: SideNavbar(),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        color: Color.fromRGBO(197, 86, 8, 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 13.0),
          child: GNav(
            selectedIndex: _selectedIndex,
            gap: 4,
            padding: EdgeInsets.all(10),
            backgroundColor: Color.fromRGBO(197, 86, 8, 1),
            color: Colors.white,
            activeColor: Colors.black,
            tabBackgroundColor: Color.fromRGBO(241, 189, 152, 1),
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index; 
                getUser();
              });
            },
            tabs: [
              GButton(icon: Icons.home_outlined, text: 'Home'),
              GButton(icon: Icons.explore_outlined, text: 'Assessments'),
              GButton(icon: Icons.menu_book, text: 'Courses'),
              GButton(icon: Icons.play_circle_outlined, text: 'Sessions'),
            ],
          ),
        ),
      ),
    );
  }
}
