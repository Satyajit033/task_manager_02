import 'package:flutter/material.dart';
import 'package:task_manager_2/ui/screens/on_boarding/canceled_task_list_screen.dart';
import 'package:task_manager_2/ui/screens/on_boarding/completed_task_list_screen.dart';
import 'package:task_manager_2/ui/screens/on_boarding/new_task_list_screen.dart';
import 'package:task_manager_2/ui/screens/on_boarding/progress_task_list_screen.dart';

class BottomNavBaseScreen extends StatefulWidget {
  const BottomNavBaseScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBaseScreen> createState() => _BottomNavBaseScreenState();
}

class _BottomNavBaseScreenState extends State<BottomNavBaseScreen> {

  int _selectedScreenIndex = 0;

  final List<Widget>_screens = const [
        NewTaskListScreen(),
        CompletedTaskListScreen(),
        CanceledTaskListScreen(),
        ProgressTaskListScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex],

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon:Icon(Icons.list_alt_outlined),label:"New Task",),
          BottomNavigationBarItem(icon:Icon(Icons.check_circle_outline),label:"Completed"),
          BottomNavigationBarItem(icon:Icon(Icons.cancel_outlined),label:"Canceled"),
          BottomNavigationBarItem(icon:Icon(Icons.alarm_outlined),label:"Progress"),
        ],
        onTap: (int index){
          _selectedScreenIndex=index;
          if(mounted){
            setState(() {});
          }
        },
        currentIndex:_selectedScreenIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
