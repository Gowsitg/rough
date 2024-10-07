import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';

//Token
Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

//getUserId
Future<int?> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('UserId');
}

//getUserrole
Future<String?> getUserRole() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('UserRole');
}

//Login
Future<Map<String, dynamic>> login(String email, String password) async {
  final url = Uri.parse('https://api.vantharr.in/accounts/login/');

  Map<String, String> body = {
    "email": email,
    "password": password,
  };

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else if (response.statusCode == 401) {
      final data = jsonDecode(response.body);
      throw Exception(data['message'] ?? 'Unauthorized');
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Error: $error');
  }
}

//Course
Future<http.Response> getCourse() async {
  final url = Uri.parse('https://api.vantharr.in/courses/site-course-list/');
  final response = await http.get(url);
  return response;
}

// Image Upload
Future<dynamic> uploadApiImage(Uint8List imageBytes, String fileName) async {
  String? token = await getToken();

  Uri url = Uri.parse('https://api.vantharr.in/miscellenous/s3-upload/');
  var request = http.MultipartRequest('POST', url);
  var myfile = http.MultipartFile.fromBytes(
    'image',
    imageBytes,
    filename: fileName,
  );

  request.files.add(myfile);

  request.headers['Authorization'] = 'Token $token';

  var response = await request.send();

  if (response.statusCode == 200) {
    var data = await response.stream.bytesToString();
    return jsonDecode(data);
  } else {
    print('Failed to upload image. Status code: ${response.statusCode}');
    return null;
  }
}

//password chnage
Future<http.Response> changeNewPassword(String id, String userInput) async {
  String? token = await getToken();
  final Map<String, dynamic> requestBody = {
    "new_password": userInput,
  };
  final response = await http.put(
    Uri.parse('https://api.vantharr.in//accounts/change-password/$id/'),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(requestBody),
  );

  return response;
}


Future<http.Response> getUserDetaile() async {
  int? UserId = await getUserId();
  String? UserRole = await getUserRole();
  String? token = await getToken();
    Uri url;

    if(UserRole == 'student') {
       url = Uri.parse('https://api.vantharr.in/accounts/students/5/');
    } else {
       url = Uri.parse('https://api.vantharr.in/accounts/trainers/5/');
    }
    
    final response = await http.get(
    url,
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    },
  );
    return response;
}