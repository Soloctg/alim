import 'package:flutter/material.dart';
import 'package:alim/screens/details_screen.dart';
import 'package:alim/screens/home_screen.dart';
import 'package:alim/screens/onboarding_screen.dart';

void main() {
  runApp(AlimApp());
}

class AlimApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alim App',
      theme: ThemeData(
        primaryColor: Color(0xFFD17B33),
        scaffoldBackgroundColor: const Color.fromARGB(255, 22, 1, 1),
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => OnboardingScreen(),
        '/home': (context) => HomeScreen(),
        '/details': (context) => DetailsScreen(),
      },
    );
  }
}
