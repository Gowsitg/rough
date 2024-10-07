import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vanthar/AppScreens/AppLayout.dart';
import '../Shared/Reusable.dart';
import 'ForgotPassword.dart';
import '../ApiHelper/ApiServices.dart';

class Login extends StatefulWidget {
  final int selectedIndex;
  const Login({Key? key, this.selectedIndex = 0}) : super(key: key);
  @override
  State<Login> createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _selectedIndex;

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
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //App image
                Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Image.asset('assets/images/newlogo.png',
                      fit: BoxFit.cover),
                ),
                SizedBox(height: 60),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //welcome text
                    Text(
                      'Welcome Back!',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Login to your account and enjoy learning...',
                      style: TextStyle(
                          fontSize: 16, color: Color.fromRGBO(0, 0, 0, .5)),
                    ),
                    SizedBox(height: 40),
                    //tab bar
                    // Container(
                    //   decoration: BoxDecoration(
                    //     // color: const Color.fromRGBO(231, 217, 207, 1),
                    //     borderRadius: BorderRadius.circular(20),
                    //   ),
                    //   child: TabBar(
                    //     physics: const NeverScrollableScrollPhysics(),
                    //     controller: _tabController,
                    //     indicatorColor: const Color.fromARGB(255, 0, 0, 0),
                    //     indicatorPadding:
                    //         EdgeInsets.symmetric(horizontal: 15.0),
                    //     dividerColor: Colors.transparent,
                    //     tabs: [
                    //       Tab(
                    //         child: AnimatedContainer(
                    //           duration: Duration(
                    //               milliseconds:
                    //                   300), // Transition duration for color change
                    //           width: double.infinity,
                    //           height: double.infinity,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(20),
                    //             color: _selectedIndex == 0
                    //                 ? null
                    //                 : const Color.fromRGBO(231, 217, 207,
                    //                     1), // Apply color transition
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
                    //           duration: Duration(
                    //               milliseconds:
                    //                   300), // Transition duration for color change
                    //           width: double.infinity,
                    //           height: double.infinity,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(20),
                    //             color: _selectedIndex == 1
                    //                 ? null
                    //                 : const Color.fromRGBO(231, 217, 207,
                    //                     1), // Apply color transition
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
                    //     labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    //     indicator: BoxDecoration(
                    //       color: Color.fromRGBO(243, 148, 81, 1),
                    //       borderRadius: BorderRadius.circular(20),
                    //     ),
                    //     indicatorSize: TabBarIndicatorSize.tab,
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    // //tab body
                    // Container(
                    //   height: 300,
                    //   child: TabBarView(
                    //     physics: const NeverScrollableScrollPhysics(),
                    //     controller: _tabController,
                    //     children: [
                    //       EmailLogin(),
                    //       PhoneLogin(),
                    //     ],
                    //   ),
                    // ),
                    //terms content
                    EmailLogin(),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: Text(
                          'By continuing, you agree to our Terms of Service and Privacy Policy.',
                          style: TextStyle(
                              fontSize: 14, color: Color.fromRGBO(0, 0, 0, .5)),
                          textAlign: TextAlign.center,
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

class EmailLogin extends StatefulWidget {
  EmailLogin({Key? key});
  @override
  _EmailLoginState createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _hasText = false;
  bool invalid = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    // Listen for changes in the TextField
    passwordController.addListener(() {
      setState(() {
        _hasText = passwordController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  snackBarMsg(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(value)),
    );
  }

  //submit form
  Future<void> SubmitFormEmail() async {
    if (_formKey.currentState!.validate()) {
      String _email = emailController.text;
      String _password = passwordController.text;
      setState(() {
        isLoading = true;
      });
      try {
        final data = await login(_email, _password);

        if (data['status'] == 200) {
          emailController.clear();
          passwordController.clear();

          String token = data['data']['token'];
          String Role = data['data']['role'];
          int Id = data['data']['user_id'];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('token', token);
          await prefs.setString('UserRole', Role);
          await prefs.setInt('UserId', Id);

          snackBarMsg('Login Successfuuly!');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AppLayout()),
          );
          setState(() {
            isLoading = false;
          });
        } else {
          snackBarMsg(data['message']);
          setState(() {
            isLoading = false;
          });
        }
      } catch (error) {
        setState(() {
          isLoading = false;
        });
        snackBarMsg('$error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
          TextFormField(
              controller: passwordController,
              obscureText: !_isObscure,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle:
                    TextStyle(color: const Color.fromRGBO(128, 128, 128, 1)),
                prefixIcon: Icon(Icons.lock_outline,
                    color: const Color.fromRGBO(128, 128, 128, 1)),
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
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Color.fromRGBO(217, 217, 217, 1),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Password';
                } else if (value.length <= 5) {
                  return 'Enter Minimum 6 digit';
                } else {
                  return null;
                }
              }),

          Container(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPassword()),
                );
              },
              child: Text(
                "Forget Password?",
                style: TextStyle(
                  color: Color.fromRGBO(8, 8, 38, 0.4),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 50.0,
            child: ElevatedButton(
              onPressed: () {
                SubmitFormEmail();
              },
              child: isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2.0,
                      ),
                    )
                  : Text('Login'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                backgroundColor: Color.fromRGBO(243, 148, 81, 1),
                foregroundColor: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class PhoneLogin extends StatefulWidget {
  PhoneLogin({Key? key});
  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = false;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _hasText = false;
  bool invalidText = false;

  @override
  void initState() {
    super.initState();

    passwordController.addListener(() {
      setState(() {
        _hasText = passwordController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  snackBarMsg(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(value)),
    );
  }

  //submit form
  Future<void> SubmitForm() async {
    if (_formKey.currentState!.validate()) {
      String _phoneNumber = phoneController.text;
      String _password = passwordController.text;
      try {
        final data = await login(_phoneNumber, _password);

        if (data['status'] == 200) {
          phoneController.clear();
          passwordController.clear();

          String token = data['data']['token'];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('token', token);
          snackBarMsg('Login Successfuuly!');
          // await prefs.setString('Tokken', data['token']);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AppLayout()),
          );
        } else {
          snackBarMsg(data['message']);
        }
      } catch (error) {
        snackBarMsg('$error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          //phone number
          TextFormField(
              keyboardType: TextInputType.phone,
              controller: phoneController,
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
                  borderRadius: BorderRadius.circular(15),
                ),
                filled: true,
                fillColor: Color.fromRGBO(217, 217, 217, 1),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter your Phone Number';
                } else if (!isPhoneNumber(value)) {
                  return 'Enter Valid Phone number';
                } else {
                  return null;
                }
              }),

          SizedBox(height: 20),
          //pasword
          TextFormField(
              obscureText: !_isObscure,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Passwors',
                hintStyle:
                    TextStyle(color: const Color.fromRGBO(128, 128, 128, 1)),
                prefixIcon: Icon(Icons.lock_outline_sharp,
                    color: const Color.fromRGBO(128, 128, 128, 1)),
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
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15),
                ),
                filled: true,
                fillColor: Color.fromRGBO(217, 217, 217, 1),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Password';
                } else if (value.length <= 5) {
                  return 'Enter Minimum 6 digit';
                } else {
                  return null;
                }
              }),

          Visibility(
            visible: invalidText,
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Invalid Credentials',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ForgotPassword(selectedIndex: 1)),
                );
              },
              child: Text(
                "Forget Password?",
                style: TextStyle(
                  color: Color.fromRGBO(8, 8, 38, 0.4),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50.0,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                SubmitForm();
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Color.fromRGBO(243, 148, 81, 1),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
