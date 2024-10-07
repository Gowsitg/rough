import 'dart:convert';
import 'package:flutter/material.dart';
import '../ApiHelper/Session_Service.dart';
import '../Shared/Reusable.dart';
import '../Shared/VideoPlayer.dart';

class SessionDetaile extends StatefulWidget {
  final String sessionId;
  const SessionDetaile(this.sessionId, {Key? key}) : super(key: key);

  @override
  State<SessionDetaile> createState() => _SessionDetaileState();
}

class _SessionDetaileState extends State<SessionDetaile> {
  bool isLoading = true;
  late final SessionData;

  @override
  void initState() {
    super.initState();
    getDetaile(widget.sessionId);
  }

  getDetaile(Id) async {
    try {
      final response = await SessionService().SessionDetaile(Id);

      if (response.statusCode == 200) {
        Map<String, dynamic> getData = jsonDecode(response.body);
        setState(() {
          SessionData = getData['data'];
          isLoading = false;
        });
        print(SessionData);
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

  Player(recUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => UniversalVideoPlayer(videoUrl: recUrl)),
    );
  }

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
        title: Text('Recorded Session',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(243, 148, 81, 1),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    GestureDetector(
                      onTap: () => Player(SessionData['recording_link']),
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
                            image: AssetImage('assets/images/course1.jpeg'),
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
                    Text(
                      SessionData['session_title'],
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Information',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      removeHtmlTags(SessionData['session_description']),
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Text(
                          'Meeting Link: ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        //  TextButton(onPressed: () => li, child: child)
                        //  TextButton(SessionData['meet_link'],style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18,color: Colors.blue,overflow: eli),),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Assessment & Quiz',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    for (var list in assessmentList)
                      Container(
                        child: GestureDetector(
                          // onTap: () => viewall(),
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(right: 20, bottom: 10),
                            child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Rounded corners
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Assessment',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color.fromRGBO(
                                                    33, 147, 194, 1),
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text('50 Marks ',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromRGBO(
                                                      70, 71, 98, 1),
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text('Cloud Computing ',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  Color.fromRGBO(70, 71, 98, 1),
                                              fontWeight: FontWeight.w500)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('Cloud Comp. Basics',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 1))),
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
                                                  color: Color.fromRGBO(
                                                      70, 71, 98, 1))),
                                          Text('Time:15min',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromRGBO(
                                                      70, 71, 98, 1))),
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
