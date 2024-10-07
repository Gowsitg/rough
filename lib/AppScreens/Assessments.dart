import 'package:flutter/material.dart';
import 'package:vanthar/Shared/SearchBar.dart';
import 'AssessmentQuiz.dart';
class Assessment extends StatefulWidget {
  const Assessment({super.key});

  @override
  State<Assessment> createState() => _AssessmentState();
}

class _AssessmentState extends State<Assessment> {
 final List<Map<String, String>> coures = [
    {
      'imageUrl': 'assets/images/course2.jpeg',
      'title': 'Cloud Computing',
      'rating': '1',
    },
    {
      'imageUrl': 'assets/images/course2.jpeg',
      'title': 'Cloud Computing',
      'rating': '3',
    },
    {
      'imageUrl': 'assets/images/course2.jpeg',
      'title': 'Cloud Computing',
      'rating': '2',
    },
    {
      'imageUrl': 'assets/images/course2.jpeg',
      'title': 'Cloud Computing',
      'rating': '1',
    },
    {
      'imageUrl': 'assets/images/course2.jpeg',
      'title': 'Cloud Computing',
      'rating': '2',
    },
  ];
  onSearch(value) {}

  navigateQuiz() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AssessmentQuiz()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(217, 217, 217, 1),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Searchbar(onSearch: onSearch),
              SizedBox(
                height: 20,
              ),
              Text(
                'Assessment & Quiz',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Cloud Computing',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
               Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: [
              for (var course in coures.take(4))
                GestureDetector(
                  onTap: () => navigateQuiz(),
                  child: Container(
                  width: MediaQuery.of(context).size.width * 0.43,
                  child: Column(
                    children: [
                      Card(
                          child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                colorFilter: ColorFilter.mode(Colors.black.withOpacity(.4),BlendMode.multiply ),
                                image: AssetImage(course['imageUrl']!),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 10, bottom: 10),
                                  child: Center(
                                     child: Text('Quiz',style: TextStyle(fontSize: 20,color:Colors.white,fontWeight: FontWeight.w800),),
                                  )
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
                                      course['title'] ?? 'No Title',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text('Lessons 1-5',style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey[600]),),
                                        Text(
                                          '1:30 Hours',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey[600]),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ),
                          SizedBox(height: 20),
                        ],
                      )),
                    ],
                  ),
                ),
                )
            ],
          )
            ],
          ),
        ));
  }
}
