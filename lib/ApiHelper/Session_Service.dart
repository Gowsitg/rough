import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  // Token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  //get Session
  Future<http.Response> fetchSession(
      String filteredSession, int page, int itemsPerPage) async {
    String? token = await getToken();

    final response = await http.post(
      Uri.parse('https://api.vantharr.in/batches-sessions/session-list/'),
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

  //get by id
  Future<http.Response> SessionDetaile(String id) async {
    String? token = await getToken();
    final url =
        Uri.parse('https://api.vantharr.in/batches-sessions/sessions/$id/');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
    );
    return response;
  }
}
