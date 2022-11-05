import 'package:flutter/material.dart';
import 'package:internship/screens/main_screen.dart';
import 'package:internship/screens/resume_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      darkTheme: ThemeData(primaryColor: Colors.purple, colorScheme: ColorScheme.dark()),
       themeMode: ThemeMode.system,
       debugShowCheckedModeBanner: false,
      home: const MainScreen(),
      routes: {
        ResumeScreen.routeName: (context) => const ResumeScreen(), 
      },
    );
  }
}
