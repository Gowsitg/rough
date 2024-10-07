import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TrainerService {
  //token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  final String baseUrl = 'https://api.vantharr.in/accounts/trainers-list/';

  //get List
  Future<http.Response> fetchTrainers(
      String filteredTrainers, int page, int itemsPerPage) async {
    String? token = await getToken();

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'search': filteredTrainers,
        'page': page,
        'itemsperpage': itemsPerPage,
      }),
    );

    return response;
  }

//create traine
  Future<http.Response> createTrainer(Map<String, dynamic> trainerData) async {
    String? token = await getToken();

    final response = await http.post(
      Uri.parse('https://api.vantharr.in/accounts/trainers/'),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(trainerData),
    );

    return response;
  }

  //update traine
  Future<http.Response> updateTrainer(
      String id, Map<String, dynamic> trainerData) async {
    String? token = await getToken();

    final response = await http.put(
      Uri.parse('https://api.vantharr.in/accounts/trainers/$id/'),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(trainerData),
    );

    return response;
  }

  //delet
  Future<http.Response> Deleted_trainer(String id) async {
    String? token = await getToken();
    final response = await http.delete(
      Uri.parse('https://api.vantharr.in/accounts/trainers/$id/'),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
    );

    return response;
  }

  //get by id
  Future<http.Response> getTrainer(String id) async {
    final url = Uri.parse('https://api.vantharr.in/accounts/trainers/$id/');
    final response = await http.get(url);
    return response;
  }
}
