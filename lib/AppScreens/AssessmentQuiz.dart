import 'package:flutter/material.dart';

import '../Shared/SearchBar.dart';

class AssessmentQuiz extends StatefulWidget {
  const AssessmentQuiz({super.key});

  @override
  State<AssessmentQuiz> createState() => _AssessmentQuizState();
}

class _AssessmentQuizState extends State<AssessmentQuiz> {
  _Search(value) {}

  final List<Map<String, String?>> assessmentList = [
    {
      'imageUrl': 'assets/images/course1.jpeg',
      'title': 'Course Title 1',
      'session': 'Live',
    },
    {
      'imageUrl': 'assets/images/course2.jpeg',
      'title': 'Course Title 2',
      'session': 'Live',
    },
    {
      'imageUrl': 'assets/images/course1.jpeg',
      'title': 'Course Title 3',
      'session': 'Live',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(217, 217, 217, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(217, 217, 217, 1),
        title: Text('Assessment & Quiz  on'),
      ),
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
              Text(
                'Assessment & Quiz  ',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage('assets/images/course1.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'java',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Information',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'The Cloud Computing Quiz is a way to help you build up your confidence and provide sample questions for Cloud computing interviews. Quizzes are an interesting way of learning. So, are you ready to play the Online Cloud Computing',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Assessment & Quiz',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20,
              ),
               for(var list in assessmentList)
              Container(
                child:  GestureDetector(
                // onTap: () => viewall(),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(right: 20, bottom: 10),
                  child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Rounded corners
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text(
                              'Assessment',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(33, 147, 194, 1),
                                  fontWeight: FontWeight.w600),
                            ),
                            Text('50 Marks ',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(70, 71, 98, 1),fontWeight: FontWeight.w500)),
                            ],
                           ),
                            SizedBox(
                              height: 7,
                            ),
                            Text('Cloud Computing ',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(70, 71, 98, 1),fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Cloud Comp. Basics',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color.fromRGBO(0, 0, 0, 1))),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Question 1-10',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromRGBO(70, 71, 98, 1))),
                                Text('Time:15min',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromRGBO(70, 71, 98, 1))),
                              ],
                            )
                          ],
                        ),
                      )),
                ),
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
