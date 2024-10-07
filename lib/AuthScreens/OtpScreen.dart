import 'dart:ffi';

import 'package:flutter/material.dart';
import 'ResetPassword.dart';
import 'Login.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class Otpscreen extends StatefulWidget {
 final int selectedIndex;
  const Otpscreen({Key? key, this.selectedIndex = 0}) : super(key: key); 

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> with SingleTickerProviderStateMixin {
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
                  child: Image.asset('assets/images/newlogo.png', fit: BoxFit.cover),
                ),
                const SizedBox(height: 60),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Welcome text
                    const Text(
                      'Enter OTP',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                    //           duration: const Duration(milliseconds: 300), // Transition duration for color change
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(20),
                    //             color: _selectedIndex == 0 ? null: const Color.fromRGBO(231, 217, 207, 1),
                    //           ),
                    //           child: Center(
                    //             child: Text(
                    //               'Email',
                    //               style: TextStyle(color: _selectedIndex == 0 ? Colors.white : Colors.black),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Tab(
                    //         child: AnimatedContainer(
                    //           duration: const Duration(milliseconds: 300), // Transition duration for color change
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(20),
                    //             color: _selectedIndex == 1 ? null : const Color.fromRGBO(231, 217, 207, 1),
                    //           ),
                    //           child: Center(
                    //             child: Text(
                    //               'Phone',
                    //               style: TextStyle(color: _selectedIndex == 1 ? Colors.white : Colors.black),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //     labelColor: Colors.white,
                    //     unselectedLabelColor: Colors.black,
                    //     labelStyle: const TextStyle(fontWeight: FontWeight.bold),
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
                    //       EmailOtp(),
                    //       PhonenumOtp(),
                    //     ],
                    //   ),
                    // ),
                    // Terms content
                    EmailOtp(),
                    SizedBox(height: 40,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: const Text(
                          'By continuing, you agree to our Terms of Service and Privacy Policy.',
                          style:TextStyle(fontSize: 14,color: Color.fromRGBO(0, 0, 0, .5)),
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

class EmailOtp extends StatefulWidget {
  const EmailOtp({super.key});

  @override
  State<EmailOtp> createState() => _EmailOtpState();
}



class _EmailOtpState extends State<EmailOtp> {
    String otpCode = '';

  void submitOtp() {
    if (otpCode.length == 4) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Verification Successful"),
            content: Text("You have successfully verified your OTP."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResetPassword()),
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter 4-digit verification code')),
      );
    }
  }

  void onCodeChanged(String code) {}
  void resendCode() {
    // Resend code logic
  }
    
  @override
  Widget build(BuildContext context) {
    return Column(
       children: [
            Text(
              'Enter your 4-digit OTP sent on your gmail',
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Center(
             OtpPinField(
              maxLength: 4,
              onSubmit: (enteredOtp) {
                setState(() {
                  otpCode = enteredOtp;
                });
              },
              onChange: (value) {
                print("OTP Changed: $value");
              },
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              fieldWidth: 70,
              otpPinFieldDecoration: OtpPinFieldDecoration.custom,
              otpPinFieldStyle: OtpPinFieldStyle(
                fieldBorderRadius: 20,
                defaultFieldBackgroundColor: Color.fromRGBO(217, 217, 217, 1),
                activeFieldBackgroundColor: Color.fromRGBO(217, 217, 217, 1),
                activeFieldBorderColor: Color.fromRGBO(217, 217, 217, 1),
                defaultFieldBorderColor: Color.fromRGBO(217, 217, 217, 1),
                
              ),
            ),

            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: resendCode,
                  child: Text(
                    'Resend Code',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ),
                  Text(
                      '00:14',
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromRGBO(243, 148, 81, 1)),
                    ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 55.0,
              child: ElevatedButton(
                onPressed: submitOtp,
                child: Text('Verify OTP'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: Color.fromRGBO(243, 149, 81, 1),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
    );
  }
}

class PhonenumOtp extends StatefulWidget {
  const PhonenumOtp({super.key});

  @override
  State<PhonenumOtp> createState() => _PhonenumOtpState();
}

class _PhonenumOtpState extends State<PhonenumOtp> {
  String otpCodeNum = '';

  void submitOtpNum() {
    if (otpCodeNum.length == 4) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Verification Successful"),
            content: Text("You have successfully verified your OTP."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResetPassword(selectedIndex: 1)),
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter 4-digit verification code')),
      );
    }
  }

  void onCodeChanged(String code) {}
  void resendCode() {
    // Resend code logic
  }
  @override
  Widget build(BuildContext context) {
    return Column(
       children: [
            Text(
              'Enter your 4-digit OTP sent on your phone number',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
             OtpPinField(
              maxLength: 4,
              onSubmit: (enteredOtp) {
                setState(() {
                  otpCodeNum = enteredOtp;
                });
              },
              onChange: (value) {
                print("OTP Changed: $value");
              },
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              fieldWidth: 70,
              otpPinFieldDecoration: OtpPinFieldDecoration.custom,
              otpPinFieldStyle: OtpPinFieldStyle(
                fieldBorderRadius: 20,
                defaultFieldBackgroundColor: Color.fromRGBO(217, 217, 217, 1),
                activeFieldBackgroundColor: Color.fromRGBO(217, 217, 217, 1),
                activeFieldBorderColor: Color.fromRGBO(217, 217, 217, 1),
                defaultFieldBorderColor: Color.fromRGBO(217, 217, 217, 1),
                
              ),
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: resendCode,
                  child: Text(
                    'Resend Code',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ),
                  Text(
                      '00:14',
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromRGBO(243, 148, 81, 1)),
                    ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 55.0,
              child: ElevatedButton(
                onPressed: submitOtpNum,
                child: Text('Verify OTP'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: Color.fromRGBO(243, 149, 81, 1),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
    );
  }
}