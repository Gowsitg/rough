import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../AuthScreens/Login.dart';
import '../AdminSreen/Dashboard.dart';
import '../AdminSreen/Students.dart';
import '../AdminSreen/Trainer.dart';


class SideNavbar extends StatefulWidget {
  @override
  _SideNavbarState createState() => _SideNavbarState();
}

class _SideNavbarState extends State<SideNavbar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadSelectedIndex();
  }

  Future<void> _loadSelectedIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedIndex = prefs.getInt('selectedIndex') ?? 0; 
    });
  }

  Future<void> _saveSelectedIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedIndex', index);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromRGBO(152, 146, 146, 1),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 100,
            margin: EdgeInsets.only(top: 40),
            child: Center(
              child: Image.asset('assets/images/newlogo.png', fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: Column(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/images.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Rhaj',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '@soueurhaj',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(255, 255, 255, .8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          ...List.generate(2, (index) {
            // final titles = ['Dashboard', 'Trainer', 'Students', 'Assessments', 'Settings'];
            final titles = ['Dashboard', 'Students', 'Assessments', 'Settings'];
            final icons = [
              Icons.dashboard_outlined,
              Icons.contact_page_outlined,
              Icons.group_outlined,
              // Icons.event_available_outlined,
              // Icons.settings_outlined
            ];
            // Define your navigation pages
            final pages = [
              Dashboard(),
              // Trainer(),
              Students()
            ];

            Color iconColor = _selectedIndex == index ? Color.fromRGBO(197, 86, 8, 1) : Colors.black;

            BorderSide borderSide = _selectedIndex == index
                ? BorderSide(color: Color.fromRGBO(91, 115, 255, 1), width: 6)
                : BorderSide(color: Colors.transparent, width: 6);

            return Container(
              decoration: BoxDecoration(
                border: Border(left: borderSide), 
              ),
              child: ListTile(
                title: Text(
                  titles[index],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _selectedIndex == index ? Color.fromRGBO(197, 86, 8, 1) : Colors.black,
                  ),
                ),
                leading: Icon(
                  icons[index],
                  color: iconColor, 
                  size: 25,
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                  _saveSelectedIndex(index);
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => pages[index]), 
                  );
                },
              ),
            );
          }),
          SizedBox(height: 30),
          ListTile(
            title: Text('Logout', style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),),
            leading: Icon(Icons.login_rounded,color: Colors.black,),
            onTap: () async {
              Navigator.pop(context);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false);
             _saveSelectedIndex(0);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
      ),
    );
  }
}
