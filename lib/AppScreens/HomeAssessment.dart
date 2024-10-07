import 'package:flutter/material.dart';
import './Assessments.dart';

class Assessments extends StatefulWidget {
  final Function onNavigateToAssessment; 

  const Assessments({Key? key, required this.onNavigateToAssessment}) : super(key: key);


  @override
  State<Assessments> createState() => _AssessmentsState();
}

class _AssessmentsState extends State<Assessments> {
  final List<Map<String, String>> assessment = [
    {
      'title': 'Cloud Computing',
    },
    {
      'title': 'Cloud Computing',
    },
    {
      'title': 'Cloud Computing',
    },
  ];

  viewall() {
   widget.onNavigateToAssessment();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Assessment & Quiz',
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var assessments in assessment)
                     GestureDetector(
                      onTap: () => viewall(),
                      child: Container(
                      width: 300,
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
                                Text(
                                  'Assessment',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromRGBO(33, 147, 194, 1),
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text('Cloud Computing ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromRGBO(70, 71, 98, 1))),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Question 1-10',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Color.fromRGBO(70, 71, 98, 1))),
                                    Text('Time:15min',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Color.fromRGBO(70, 71, 98, 1))),
                                  ],
                                )
                              ],
                            ),
                          )),
                    ),
                    )
                ],
              ),
            )
          ],
        ));
  }
}

