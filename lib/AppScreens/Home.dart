import 'package:flutter/material.dart';
import 'TrendingCourse.dart';
import 'HomeAssessment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'History.dart';
import 'carouselScreen.dart';

class Home extends StatefulWidget {
 final GlobalKey<ScaffoldState> scaffoldKey; 
final Function onNavigateToCourses; 
final Function onNavigateTosession; 
final Function onNavigateToAssessment; 
  Home({Key? key, required this.scaffoldKey, required this.onNavigateToCourses,required this.onNavigateTosession,required this.onNavigateToAssessment}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();

@override
  void initState() {
    super.initState();
   _loadSelectedIndex();  
   }

Future<void> _loadSelectedIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
       await prefs.setInt('selectedIndex', 0);  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(217, 217, 217, 1),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(160),
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(197, 86, 8, 1),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
            ),
            child: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.menu_outlined, size: 30, color: Colors.white),
                onPressed: () {
                  widget.scaffoldKey.currentState?.openDrawer();
                },
              ),
              title: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/newlogo.png',
                  height: 55,
                  fit: BoxFit.contain,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.notifications, color: Colors.white),
                  onPressed: () {
                  },
                ),
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(80),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'What are you going to find?',
                            prefixIcon: Icon(Icons.search),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 17, horizontal: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CarouselSlides(),
              SizedBox(
                height: 20,
              ),
              WatchHistory(onNavigateTosession: widget.onNavigateTosession,),
              SizedBox(
                height: 20,
              ),
              Assessments(onNavigateToAssessment: widget.onNavigateToAssessment),
              SizedBox(
                height: 20,
              ),
              TrendingCourse(onNavigateToCourses: widget.onNavigateToCourses,),
            ],
          ),
        ));
  }
}
