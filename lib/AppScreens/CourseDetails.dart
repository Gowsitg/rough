import 'package:flutter/material.dart';

class Coursedetails extends StatefulWidget {
  final int courseId;
  const Coursedetails(this.courseId, {Key? key}) : super(key: key);

  @override
  State<Coursedetails> createState() => _CoursedetailsState();
}

class _CoursedetailsState extends State<Coursedetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(217, 217, 217, 1),
          title: Text(
            'Courses Details',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color.fromRGBO(217, 217, 217, 1),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage('assets/images/course1.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Cloud Computing',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'The Cloud Computing Quiz is a way to help you build up your confidence and provide sample questions for Cloud computing interviews. Quizzes are an interesting way of learning. So, are you ready to play the Online Cloud Computing',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                SizedBox(
                  height: 30,
                ),
                CourseInfo()
              ],
            ),
          ),
        ));
  }
}

class CourseInfo extends StatefulWidget {
  const CourseInfo({super.key});

  @override
  State<CourseInfo> createState() => _CourseInfoState();
}

class _CourseInfoState extends State<CourseInfo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });

    _tabController.index = _selectedIndex;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Tab 1'),
            Tab(text: 'Tab 2'),
            Tab(text: 'Tab 3'),
            Tab(text: 'Tab 4'),
          ],
        ),
        Container(
          height: 900, // Set a fixed height for the TabBarView
          child: TabBarView(
            controller: _tabController,
            children: [
              Information(),
              Center(child: Text('Content for Tab 2')),
              Center(child: Text('Content for Tab 3')),
              Center(child: Text('Content for Tab 4')),
            ],
          ),
        ),
      ],
    );
  }
}

class Information extends StatelessWidget {
  const Information({super.key});

  _callFunction() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40),
        Text(
          'The core of cloud computing is made at back-end platforms with several servers for storage and processing computing. Management of Applications logic is managed through servers and effective data handling is provided by storage.',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(0, 0, 0, .6)),
        ),
        SizedBox(height: 20),
        Text(
          'The core of cloud computing is made at back-end platforms with several servers for storage and processing computing. Management of Applications logic is managed through servers and effective data handling is provided by storage.',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(0, 0, 0, .6)),
        ),
        SizedBox(height: 30),
        Center(
          child: Text(
            'Help Desk',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
        ),
        Divider(
          color: Colors.black,
          height: 20,
          thickness: 1,
        ),
        SizedBox(height: 20),
        Center(
          child: Column(
            children: [
              TextButton(
                onPressed: _callFunction,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.call_outlined, color: Colors.black),
                    SizedBox(width: 8),
                    Text(
                      '0123456789',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: _callFunction,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.email_outlined, color: Colors.black),
                    SizedBox(width: 8),
                    Text(
                      '0123456789',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
