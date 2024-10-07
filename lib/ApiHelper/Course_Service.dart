import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  // Token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }


//Subscribed Courses
  Future<http.Response> SubscribedCourses(
      String filteredSession, int page, int itemsPerPage) async {
    String? token = await getToken();

    final response = await http.post(
      Uri.parse(
          'https://api.vantharr.in/batches-sessions/student-course-list/'),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'search': filteredSession,
        'page': page,
        'itemsperpage': itemsPerPage,
      }),
    );

    return response;
  }

}
