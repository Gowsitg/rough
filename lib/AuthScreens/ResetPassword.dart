import 'package:flutter/material.dart';
import 'Login.dart';

class ResetPassword extends StatefulWidget {
  final int selectedIndex;
  const ResetPassword({Key? key, this.selectedIndex = 0}) : super(key: key); 

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword>
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
                      'Enter The New Password',
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
                    //       EmailPassword(),
                    //       PhnumberPassword(),
                    //     ],
                    //   ),
                    // ),
                    // Terms content
                     EmailPassword(),
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

class EmailPassword extends StatefulWidget {
  const EmailPassword({super.key});

  @override
  State<EmailPassword> createState() => _EmailPasswordState();
}

class _EmailPasswordState extends State<EmailPassword> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController newPasswordnumberController =
      TextEditingController();
  final TextEditingController confirmPasswordnumberController =
      TextEditingController();
  bool _isObscurenumber = true;
  bool _isObscureConfirmnumber = true;
  bool _hasTextnumber = false;
  bool _hasTextConfnumber = false;

  // Function to reset the password
  void resetPassword() {
    if (_formKey.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Password Changed"),
              content: Text("You can now sigin in with new password."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
    }
  }

  @override
  void initState() {
    super.initState();

    // Listen for changes in the TextField
    newPasswordnumberController.addListener(() {
      setState(() {
        _hasTextnumber = newPasswordnumberController.text.isNotEmpty;
      });
    });

    confirmPasswordnumberController.addListener(() {
      setState(() {
        _hasTextConfnumber = confirmPasswordnumberController.text.isNotEmpty;
      });
    });
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
              controller: newPasswordnumberController,
              obscureText: _isObscurenumber,
              decoration: InputDecoration(
                hintText: 'New Password',
                hintStyle:
                    TextStyle(color: const Color.fromRGBO(128, 128, 128, 1)),
                prefixIcon: Icon(Icons.lock_outline,
                    color: const Color.fromRGBO(128, 128, 128, 1)),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: const Color.fromRGBO(217, 217, 217, 1),
                suffixIcon: _hasTextnumber
                    ? IconButton(
                        icon: Icon(
                          _isObscurenumber
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscurenumber = !_isObscurenumber;
                          });
                        },
                      )
                    : null,
              ),
              // Add the validator for email validation
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your New Password';
                } else if (value.length <= 5) {
                  return 'Please enter a minimum 5-digits';
                }

                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: confirmPasswordnumberController,
              obscureText: _isObscureConfirmnumber,
              decoration: InputDecoration(
                hintText: 'Re-Type Password',
                hintStyle:
                    TextStyle(color: const Color.fromRGBO(128, 128, 128, 1)),
                prefixIcon: Icon(Icons.lock_outline,
                    color: const Color.fromRGBO(128, 128, 128, 1)),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: const Color.fromRGBO(217, 217, 217, 1),
                suffixIcon: _hasTextConfnumber
                    ? IconButton(
                        icon: Icon(
                          _isObscureConfirmnumber
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscureConfirmnumber = !_isObscureConfirmnumber;
                          });
                        },
                      )
                    : null,
              ),
              // Add the validator for email validation
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }  else if (newPasswordnumberController.text != value) {
                  return 'Password do not match';
                }

                return null;
              },
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () {
                  resetPassword();
                },
                child: Text('Submit'),
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

class PhnumberPassword extends StatefulWidget {
  const PhnumberPassword({super.key});

  @override
  State<PhnumberPassword> createState() => _PhnumberPasswordState();
}

class _PhnumberPasswordState extends State<PhnumberPassword> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _isObscure = true;
  bool _isObscureConfirm = true;
  bool _hasText = false;
  bool _hasTextConf = false;

  // Function to reset the password
  void resetPasswordnumber() {
    if (_formKey.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Password Changed"),
              content: Text("You can now sigin in with new password."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login(selectedIndex: 1)),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
    }
  }

  @override
  void initState() {
    super.initState();

    // Listen for changes in the TextField
    newPasswordController.addListener(() {
      setState(() {
        _hasText = newPasswordController.text.isNotEmpty;
      });
    });

    confirmPasswordController.addListener(() {
      setState(() {
        _hasTextConf = confirmPasswordController.text.isNotEmpty;
      });
    });
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
              controller: newPasswordController,
              obscureText: _isObscure,
              decoration: InputDecoration(
                hintText: 'New Password',
                hintStyle:
                    TextStyle(color: const Color.fromRGBO(128, 128, 128, 1)),
                prefixIcon: Icon(Icons.lock_outline,
                    color: const Color.fromRGBO(128, 128, 128, 1)),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: const Color.fromRGBO(217, 217, 217, 1),
                suffixIcon: _hasText
                    ? IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      )
                    : null,
              ),
              // Add the validator for email validation
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your New Password';
                } else if (value.length <= 5) {
                  return 'Please enter a minimum 5-digits';
                }

                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: confirmPasswordController,
              obscureText: _isObscureConfirm,
              decoration: InputDecoration(
                hintText: 'Re-Type Password',
                hintStyle:
                    TextStyle(color: const Color.fromRGBO(128, 128, 128, 1)),
                prefixIcon: Icon(Icons.lock_outline,
                    color: const Color.fromRGBO(128, 128, 128, 1)),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: const Color.fromRGBO(217, 217, 217, 1),
                suffixIcon: _hasTextConf
                    ? IconButton(
                        icon: Icon(
                          _isObscureConfirm
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscureConfirm = !_isObscureConfirm;
                          });
                        },
                      )
                    : null,
              ),
              // Add the validator for email validation
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else if (newPasswordController.text != value) {
                  return 'Passwords do not match';
                }

                return null;
              },
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () {
                  resetPasswordnumber();
                },
                child: Text('Submit'),
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
