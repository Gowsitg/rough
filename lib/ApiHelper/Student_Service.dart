import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class studentService {
  // Token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  final String baseUrl = 'https://api.vantharr.in/accounts/students-list/';

  //get List
  Future<http.Response> fetchStudent(
      String filteredStudent, int page, int itemsPerPage) async {
    String? token = await getToken();

    final response = await http.post( 
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'search': filteredStudent,
        'page': page,
        'itemsperpage': itemsPerPage,
      }),
    );

    return response;
  }

//create student
  Future<http.Response> createStudent(Map<String, dynamic> studentData) async {
    String? token = await getToken();

    final response = await http.post(
      Uri.parse('https://api.vantharr.in/accounts/students/'),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(studentData),
    );

    return response;
  }

  //update student
  Future<http.Response> updateStudent(
      String id, Map<String, dynamic> studentData) async {
    String? token = await getToken();

    final response = await http.put(
      Uri.parse('https://api.vantharr.in/accounts/students/$id/'),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(studentData),
    );

    return response;
  }

  //delete student
  Future<http.Response> Deleted_Student(String id) async {
    String? token = await getToken();
    final response = await http.delete(
      Uri.parse('https://api.vantharr.in/accounts/students/$id/'),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
    );

    return response;
  }

  //get by id
  Future<http.Response> getStudent(String id) async {
    final url = Uri.parse('https://api.vantharr.in/accounts/students/$id/');
    final response = await http.get(url);
    return response;
  }
}
