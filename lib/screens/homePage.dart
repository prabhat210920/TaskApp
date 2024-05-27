import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/screens/addtask.dart';
import 'package:taskapp/screens/profilePage.dart';
import 'package:taskapp/screens/taskpage.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _activeIndex = 0;

  final List<Widget> _pages = [
    const TaskPage(),
    TaskInputScreen(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: _pages[_activeIndex],
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.home, title: 'Home', ),
          TabItem(icon: Icons.add, title: 'Add'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        initialActiveIndex: 0,
        color: Colors.black26,
        activeColor: Colors.black26,
        backgroundColor: Colors.white54,
        onTap: (int index) {
          setState(() {
            _activeIndex = index;
          });
        },
      ),
    );
  }
}