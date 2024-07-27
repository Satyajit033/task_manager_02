import 'package:flutter/material.dart';
import 'package:task_manager_2/ui/screens/others/splash_screen.dart';

class TaskManager2App extends StatefulWidget {
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
  const TaskManager2App({Key? key}) : super(key: key);

  @override
  State<TaskManager2App> createState() => _TaskManager2AppState();
}

class _TaskManager2AppState extends State<TaskManager2App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        navigatorKey: TaskManager2App.globalKey,
      title: "Task Manager 2",
      home: SplashScreen(),
      themeMode: ThemeMode.light,

    theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
        primaryColor: Colors.green,

      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.6),
      ),

      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        border: OutlineInputBorder(borderSide: BorderSide.none),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

    ),



    //*****************************************

    darkTheme: ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.deepOrange,

      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.6),
      ),

      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        border: OutlineInputBorder(borderSide: BorderSide.none),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

    )

    );
  }
}
