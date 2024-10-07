import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:vanthar/ApiHelper/ApiServices.dart';
import '../Shared/Reusable.dart';
import 'package:image_picker/image_picker.dart';
import '../ApiHelper/Student_Service.dart';

class StudentForm extends StatefulWidget {
  final Map<String, dynamic>? StudentData;
  final VoidCallback onRefreshList;
  const StudentForm({Key? key, this.StudentData, required this.onRefreshList})
      : super(key: key);

  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passedourController = TextEditingController();
  bool editStudents = false;
  bool uploadImage = false;
  String _selectedImage = '';

//image uploaded
  _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Uint8List bytes = await image.readAsBytes();
      setState(() {
        uploadImage = true;
      });
      uploadApiImage(bytes, image.name).then((value) {
        setState(() {
          _selectedImage = value['data'];
          uploadImage = false;
        });
      }).onError((error, handleError) {
        setState(() {
          uploadImage = false;
        });
      });
    }
  }

  // form Submited
  SubmitForm() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> studentData = {
        "student_name": _nameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
        "phone_number": _mobileController.text,
        "designation": _designationController.text,
        "qualification": _qualificationController.text,
        "profile_image": _selectedImage,
        "work_expirience": _experienceController.text,
        "address": _addressController.text,
        "passed_out_year": _passedourController.text,
      };
      if (editStudents == false) {
        try {
          final response = await studentService().createStudent(studentData);

          final res = jsonDecode(response.body);

          if (response.statusCode == 200) {
           
            // if(res['status'] == 200) {
              Navigator.of(context).pop();
              widget.onRefreshList();
            // }
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(res['message'])),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Failed to create student: ${response.body}')),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('An error occurred: $e')),
          );
        }
      } else {
        try {
          final studentId = widget.StudentData!['id'].toString();

          final response =
              await studentService().updateStudent(studentId, studentData);
          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Student Updated successfully')),
            );
            Navigator.of(context).pop();
            widget.onRefreshList();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Failed to update student: ${response.body}')),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('An error occurred: $e')),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _mobileController.dispose();
    _designationController.dispose();
    _qualificationController.dispose();
    _experienceController.dispose();
    _addressController.dispose();
    _passedourController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.StudentData != null) {
      editStudents = true;
      _nameController.text = widget.StudentData!['student_name'] ?? '';
      _emailController.text = widget.StudentData!['email'] ?? '';
      _mobileController.text = widget.StudentData!['phone_number'] ?? '';
      _designationController.text = widget.StudentData!['designation'] ?? '';
      _qualificationController.text =
          widget.StudentData!['qualification'] ?? '';
      _experienceController.text = widget.StudentData!['work_expirience'] ?? '';
      _addressController.text = widget.StudentData!['address'] ?? '';
      _selectedImage = widget.StudentData!['profile_image'] ?? '';
      _passedourController.text = widget.StudentData!['passed_out_year'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Student Form'),
          actions: [
            IconButton(
              icon: Icon(Icons.close, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: (_selectedImage != null &&
                                      _selectedImage.isNotEmpty &&
                                      Uri.tryParse(_selectedImage)
                                              ?.hasAbsolutePath ==
                                          true)
                                  ? NetworkImage(_selectedImage)
                                  : AssetImage('assets/images/noimage.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: uploadImage == true
                            ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text('Upload Image'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          backgroundColor: Color.fromRGBO(243, 148, 81, 1),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    controller: _nameController,
                    labelText: 'Name',
                    hintText: ' ',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    controller: _emailController,
                    labelText: 'Email',
                    hintText: ' ',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    controller: _passwordController,
                    labelText: 'Password',
                    hintText: ' ',
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    controller: _mobileController,
                    labelText: 'Mobile Number',
                    hintText: ' ',
                    maxLength: 10,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a mobile number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    controller: _designationController,
                    labelText: 'Designation',
                    hintText: ' ',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Designation';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    controller: _qualificationController,
                    labelText: 'Qualification',
                    hintText: ' ',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Qualification';
                      }
                      return null;
                    },
                  ),
                 
                  SizedBox(height: 20),
                  CustomTextFormField(
                    controller: _passedourController,
                    labelText: 'Passed Out Year',
                    hintText: ' ',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a passed out year';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    controller: _experienceController,
                    labelText: 'Experience',
                    hintText: ' ',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Experience';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    controller: _addressController,
                    labelText: 'Address',
                    hintText: ' ',
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Colors.grey,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            SubmitForm();
                          },
                          child: Text('Submit'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Color.fromRGBO(243, 148, 81, 1),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
