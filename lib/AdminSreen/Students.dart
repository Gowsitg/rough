import 'package:flutter/material.dart';
import 'package:vanthar/ApiHelper/ApiServices.dart';
import 'dart:convert';
import '../Shared/Reusable.dart';
import '../Shared/SearchBar.dart';
import '../ApiHelper/Student_Service.dart';
import 'StudentForm.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {

   List<dynamic> futureStudends = [];
  final studentService _trainerService = studentService();
  bool isLoading = true;
  String? errorMessage;
  int _currentPage = 1;
  int _itemsPerPage = 5;
  final List<int> _itemsPerPageOptions = [5, 10, 20, 30, 40,50,100];
  int _totalPages = 0;
  String filteredStudent = '';
  
  @override
  void initState() {
    super.initState();
    getStudentList();
  }

  void _filterTrainers(String query) {
    if (query.isNotEmpty) {
      setState(() {
        filteredStudent = query;
      });
    } else {
      filteredStudent = '';
    }
    getStudentList();
   
  }

  getStudentList() async {
    try {
      final response = await _trainerService.fetchStudent(
          filteredStudent, _currentPage, _itemsPerPage);
          // print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        setState(() {
          futureStudends = jsonResponse['data']['list'];
          final TotalPages = jsonResponse['data']['total_pages'];
          _totalPages = (TotalPages / _itemsPerPage).ceil();

          isLoading = false;
          // print(_totalPages);
        });
      } else {
        throw Exception('Failed to load trainers: ${response.reasonPhrase}');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load trainers: $e';
        isLoading = false;
      });
    }
  }

  void _onItemsPerPageChanged(int? newValue) {
    if (newValue != null) {
      setState(() {
        _itemsPerPage = newValue;
        _currentPage = 1;
        getStudentList();
      });
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
        getStudentList();
      });
    }
  }

  void _goToNextPage() {
    if (_currentPage < _totalPages) {
      setState(() {
        _currentPage++;
        getStudentList();
      });
    }
  }

  deleteStudents(value) async {
    try {
      final trainerId = value.toString();

      final response = await studentService().Deleted_Student(trainerId);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Trainer Deleted successfully')),
        );
        Navigator.of(context).pop();
        getStudentList();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete trainer: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromRGBO(217, 217, 217, 1),
      appBar: AppBar(title: const Text('Student'),backgroundColor: Color.fromRGBO(217, 217, 217, 1)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Searchbar(onSearch: _filterTrainers),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Manage Student',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _openTrainerFormDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      backgroundColor: Color.fromRGBO(243, 148, 81, 1),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Container(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Color.fromRGBO(243, 148, 81, 1),
                      ))
                    : errorMessage != null
                        ? Center(child: Text(errorMessage!))
                        : Column(
                            children: [
                              SizedBox(height: 20),
                              for (var Students in futureStudends)
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Card(
                                    color: Colors.white,
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
                                              Container(
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: Students[
                                                                'profile_image'] !=
                                                            ''
                                                        ? NetworkImage(Students[
                                                            'profile_image'])
                                                        : AssetImage(
                                                            'assets/images/noimage.jpg'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                    width: 2,
                                                    style: BorderStyle.solid,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      _changeDialog(context,
                                                          Students['id']);
                                                    },
                                                    icon: Icon(Icons
                                                        .lock_reset_outlined),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      _openTrainerFormDialog(
                                                          context,
                                                          trainerData: Students);
                                                    },
                                                    icon: Icon(
                                                        Icons.edit_outlined),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title:
                                                                Text("Delete"),
                                                            content: Text(
                                                                "Do you want Delete this Trainer?"),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: Text(
                                                                    'Cancel'),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  deleteStudents(
                                                                      Students[
                                                                          'id']);
                                                                },
                                                                child: Text(
                                                                    'Delete'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    icon: Icon(
                                                        Icons.delete_outline),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            Students['student_name'] ?? '--',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(Students['email'] ?? '--',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400)),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  Students['phone_number'] ??
                                                      '--',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              Text(
                                                  formatDate(Students[
                                                          'created_at']) ??
                                                      '--',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if(futureStudends.length >= 5)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.chevron_left_outlined,size: 35,),
                                    onPressed: _currentPage > 1
                                        ? _goToPreviousPage
                                        : null, 
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.50,
                                    child: DropdownButton<int>(
                                    value: _itemsPerPage,
                                    items:
                                        _itemsPerPageOptions.map((int value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text(value.toString()),
                                      );
                                    }).toList(),
                                    onChanged: _onItemsPerPageChanged,
                                  ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.chevron_right_outlined,size: 35,),
                                    onPressed: _currentPage < _totalPages
                                        ? _goToNextPage
                                        : null, 
                                  ),
                                ],
                              )
                            ],
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }

//tranier form
  void _openTrainerFormDialog(BuildContext context,
      {Map<String, dynamic>? trainerData}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: StudentForm(StudentData: trainerData, onRefreshList: getStudentList),
        );
      },
    );
  }

  change_password(id, userInput) async {
    final trainerId = id.toString();
    try {
      final response = await changeNewPassword(trainerId, userInput);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Student Password is updated')),
        );
        getStudentList();
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to Password is updated: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

//chnage password
  void _changeDialog(BuildContext context, id) {
    final TextEditingController _passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Change password',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: Form(
            key: _formKey,
            child: CustomTextFormField(
              controller: _passwordController,
              labelText: 'Password',
              hintText: ' ',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                } else if (value.length <= 5) {
                  return 'Enter Minimum 6-digit';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(
                        color: Colors.black.withOpacity(0.5), width: 2),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                String userInput = _passwordController.text;
                if (_formKey.currentState!.validate()) {
                  change_password(id, userInput);
                }
              },
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(243, 148, 81, 1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(
                        color: Color.fromRGBO(243, 148, 81, 1), width: 2),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
