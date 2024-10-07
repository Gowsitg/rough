import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vanthar/AuthScreens/Login.dart';
import 'package:vanthar/AuthScreens/OtpScreen.dart';
import '../Shared/Reusable.dart';

class ForgotPassword extends StatefulWidget {
  final int selectedIndex;
  const ForgotPassword({Key? key, this.selectedIndex = 0}) : super(key: key); 

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int  _selectedIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

  _selectedIndex = (widget.selectedIndex == 1) ? 1 : 0;
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
    
     _tabController.index = _selectedIndex;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // App image
                Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child:
                      Image.asset('assets/images/newlogo.png', fit: BoxFit.cover),
                ),
                const SizedBox(height: 60),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Welcome text
                    const Text(
                      'Reset Password',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 40),
                    // Tab bar
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(20),
                    //   ),
                    //   child: TabBar(
                    //     controller: _tabController,
                    //     indicatorColor: const Color.fromARGB(255, 0, 0, 0),
                    //     // indicatorPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                    //     dividerColor: Colors.transparent,
                    //     tabs: [
                    //       Tab(
                    //         child: AnimatedContainer(
                    //           duration: const Duration(
                    //               milliseconds:
                    //                   300), // Transition duration for color change
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(20),
                    //             color: _selectedIndex == 0
                    //                 ? null
                    //                 : const Color.fromRGBO(231, 217, 207, 1),
                    //           ),
                    //           child: Center(
                    //             child: Text(
                    //               'Email',
                    //               style: TextStyle(
                    //                   color: _selectedIndex == 0
                    //                       ? Colors.white
                    //                       : Colors.black),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Tab(
                    //         child: AnimatedContainer(
                    //           duration: const Duration(
                    //               milliseconds:
                    //                   300), // Transition duration for color change
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(20),
                    //             color: _selectedIndex == 1
                    //                 ? null
                    //                 : const Color.fromRGBO(231, 217, 207, 1),
                    //           ),
                    //           child: Center(
                    //             child: Text(
                    //               'Phone',
                    //               style: TextStyle(
                    //                   color: _selectedIndex == 1
                    //                       ? Colors.white
                    //                       : Colors.black),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //     labelColor: Colors.white,
                    //     unselectedLabelColor: Colors.black,
                    //     labelStyle:
                    //         const TextStyle(fontWeight: FontWeight.bold),
                    //     indicator: BoxDecoration(
                    //       color: const Color.fromARGB(255, 243, 149, 81),
                    //       borderRadius: BorderRadius.circular(20),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    // // Tab body
                    // SizedBox(
                    //   height: 300,
                    //   child: TabBarView(
                    //      physics: const NeverScrollableScrollPhysics(),
                    //     controller: _tabController,
                    //     children: [
                    //       Email(),
                    //       Phonenum(),
                    //     ],
                    //   ),
                    // ),
                    // Terms content
                     Email(),
                     SizedBox(height: 40,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: const Text(
                          'By continuing, you agree to our Terms of Service and Privacy Policy.',
                          style: TextStyle(fontSize: 14,color: Color.fromRGBO(0, 0, 0, .5)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text(
                          "Back to Login",
                          style: TextStyle(
                            color: const Color.fromRGBO(243, 148, 81, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Email extends StatefulWidget {
  const Email({super.key});

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  bool invalid = false;
  int _start = 15; 
  Timer? _timer;

  
  Future<void> SubmitFormEmail() async {
    if (_formKey.currentState!.validate()) {
      String _email = emailController.text;
      // if (_email == widget.emailres && _password == widget.passwordValue) {
      setState(() {
        invalid = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Code Send Successful"),
            content: Text(
                "A verification code has been sent successfully to gmail."),
            actions: [
              TextButton(
                onPressed: () {
                  emailController.clear();
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Otpscreen()),
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );

      // } else {
      // setState(() {
      //   invalid = true;
      // });
      // }
    }
  }

 void startTimer() {
  _start = 15; 
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

 @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            //email field
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle:
                    TextStyle(color: const Color.fromRGBO(128, 128, 128, 1)),
                prefixIcon: Icon(Icons.mail_outline,
                    color: const Color.fromRGBO(128, 128, 128, 1)),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: const Color.fromRGBO(217, 217, 217, 1),
              ),
              // Add the validator for email validation
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else if (!isValidEmail(value)) {
                  return 'Please enter a valid email address';
                }

                return null;
              },
            ),
            SizedBox(height: 20),
            Container(
                alignment: Alignment.center,
                child: 
                  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 _start == 0 ?
                
                 Text(''):
                     Row(
                      children: [
                        Text(
                       'Resend OTP',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey),
                    ),
                     SizedBox(width: 8,),
                     Text(
                      '00:$_start',
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromRGBO(243, 148, 81, 1)),
                    ),
                      ],
                     )
              ],
            ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () {
                  SubmitFormEmail();
                  startTimer;
                },
                child: Text('Send OTP'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  backgroundColor: Color.fromRGBO(243, 149, 81, 1),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ));
  }
}

class Phonenum extends StatefulWidget {
  const Phonenum({super.key});

  @override
  State<Phonenum> createState() => _PhonenumState();
}

class _PhonenumState extends State<Phonenum> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phnumberController = TextEditingController();
  bool invalidText = false;

  Future<void> SubmitFormphnumber() async {
    if (_formKey.currentState!.validate()) {
      String _phoneNumber = phnumberController.text;

      // if (_phoneNumber == widget.phoneNumber.toString() ) {
      setState(() {
        invalidText = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Code Send Successful"),
            content: Text(
                "A verification code has been sent successfully to gmail."),
            actions: [
              TextButton(
                onPressed: () {
                  phnumberController.clear();
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Otpscreen(selectedIndex: 1)),
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );

      // } else {
      //   setState(() {
      //     invalidText = true;
      //   });
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            //email field
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: phnumberController,
              maxLength: 10,
              decoration: InputDecoration(
                hintText: 'Phone Number',
                counterText: '',
                hintStyle:
                    TextStyle(color: const Color.fromRGBO(128, 128, 128, 1)),
                prefixIcon: Icon(Icons.call_outlined,
                    color: const Color.fromRGBO(128, 128, 128, 1)),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: const Color.fromRGBO(217, 217, 217, 1),
              ),
              // Add the validator for email validation
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else if (!isPhoneNumber(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      'Resend OTP',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    Text(
                      '00:14',
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromRGBO(243, 148, 81, 1)),
                    ),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () {
                  SubmitFormphnumber();
                },
                child: Text('Send OTP'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  backgroundColor: Color.fromRGBO(243, 149, 81, 1),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ));
  }
}
