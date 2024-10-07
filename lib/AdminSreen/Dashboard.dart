import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      backgroundColor: Color.fromRGBO(217, 217, 217, 1),
      appBar: AppBar(title: const Text('Dashboard'),backgroundColor: Color.fromRGBO(217, 217, 217, 1)),
    );
  }
}
